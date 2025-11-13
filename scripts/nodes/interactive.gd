@tool @icon("res://addons/odyssey/icons/interactive.svg")
class_name Interactive extends Area3D

signal toggled()
signal toggled_on()
signal toggled_off()
signal charge_started()
signal charge_percent(amnt: float)
signal charge_ended()
signal interacted(pawn: Pawn, form: Form)
signal highlight_changed()

enum Form { INTERACT, ENTERED, EXITED }
enum ToggleIterationMode { FORWARD, BACKWARD, RANDOM }
enum Highlight { NONE, FOCUSED }

@export var label: String = "Interact"
@export var flow_script: FlowScript ## Optional script to play on interact.
@export var behavior: BTPlayer
@export var label_world_space_offset := Vector3.ZERO
@export var humanoid_lookat_offset := Vector3.ZERO
var can_interact := func(_pawn: Pawn): return true

@export var disabled := false:
	get: return not monitorable
	set(d): monitorable = not d

@export var highlight := Highlight.NONE:
	set(h):
		highlight = h
		highlight_changed.emit()

@export_group("Toggleable")
@export var toggleable := false:
	get: return toggle_states != 0
	set(t):
		if t:
			if toggle_states == 0:
				toggle_states = 1
		else:
			toggle_states = 0
@export var on := false:
	get: return toggle_state != 0
	set(o):
		if o:
			if toggle_state == 0:
				toggle_state = 1
		else:
			toggle_state = 0
@export var toggle_states := 0 ## 0 == no toggle. 1 = on/off.
@export var toggle_state := 0:
	set(t):
		toggle_state = t
		if toggle_state == 0:
			toggled_off.emit()
		else:
			toggled_on.emit()
		toggled.emit()
@export var toggle_labels: PackedStringArray = ["Interact [Turn Off]", "Interact [Turn On]"]
@export var toggle_iteration_mode := ToggleIterationMode.FORWARD ## Only when toggle_states > 0.
@export var toggle_iteration_loop := true ## Loop or clamp.
var toggle_count := 0 ## How many times interactive was toggled.
var _toggle_next := 0 ## Next state we will enter. Needed for setting accurate labels.

@export_group("Chargeable")
@export var chargeable := false: ## Based on charge_time state. 0.0 == false.
	get: return charge_time != 0.0
	set(c):
		if c:
			if charge_time == 0.0:
				charge_time = 1.0
		else:
			charge_time = 0.0
@export var charge_time := 0.0 ## Seconds to hold interact down.
@export var charge_instant_reset := true
@export var charge_increase_scale := 1.0
@export var charge_decrease_scale := 1.0
var _charging := false
var _charge_time := 0.0
var _charge_pawn: Pawn
var _charge_form: Form

@export_group("Enterable & Exitable")
@export var interact_on_enter := false ## Interaction occurs when object enters.
@export var interact_on_exit := false ## Interaction occurs when object leaves.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var ioe_expression: String ## Expression to test if interact_on_enter == true.
@export var ioe_delay := 0.1 ## Slight time delay, so it's not instant. If no longer inside, this cancels interaction.
@export var ioe_scene: PackedScene ## A scene to swap to if interaction occurs.

func _init() -> void:
	add_to_group(&"Interactive")
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func _ready() -> void:
	body_entered.connect(_entered)
	body_exited.connect(_exited)
	set_process(false)

func _entered(body: Node3D):
	if not interact_on_enter: return
	if ioe_delay == 0:
		interact(body, Form.ENTERED)
	else:
		Global.wait(ioe_delay, func():
			if body in get_overlapping_bodies():
				interact(body, Form.ENTERED))

func _exited(body: Node3D):
	if not interact_on_exit: return
	if ioe_delay == 0:
		interact(body, Form.EXITED)
	else:
		Global.wait(ioe_delay, func():
			if not body in get_overlapping_bodies():
				interact(body, Form.EXITED))

func interact(pawn: Pawn, form := Form.INTERACT):
	if not can_interact.call(pawn): return
	if charge_time == 0:
		_interacted(pawn, form)
	else:
		_charging = true
		_charge_pawn = pawn
		_charge_form = form
		charge_started.emit()
		set_process(true)

## Cancel the interaction.
## Only used when hold_time != 0.0
func cancel(pawn: Pawn):
	if _charging and pawn == _charge_pawn:
		_charging = false
		_charge_pawn = null
		charge_ended.emit()

func _process(delta: float) -> void:
	if _charging:
		_charge_time += delta * charge_increase_scale
		if _charge_time >= charge_time:
			set_process(false)
			_charge_time = charge_time
			_interacted(_charge_pawn, _charge_form)
			_charge_pawn = null
	else:
		if charge_instant_reset:
			_charge_time = 0.0
		else:
			_charge_time -= delta * charge_decrease_scale
		
		if _charge_time <= 0.0:
			set_process(false)
			_charge_time = 0.0
	
	var percent := remap(_charge_time, 0.0, charge_time, 0.0, 1.0)
	charge_percent.emit(percent)
	print(percent)

func _interacted(pawn: Pawn, form: Form) -> void:
	interacted.emit(pawn, form)
	
	if toggleable:
		toggle_count += 1
		toggle_state = _toggle_next
		match toggle_iteration_mode:
			ToggleIterationMode.FORWARD: _toggle_next += 1
			ToggleIterationMode.BACKWARD: _toggle_next -= 1
			ToggleIterationMode.RANDOM: _toggle_next = randi() % toggle_states
			
		if toggle_iteration_loop:
			_toggle_next = wrapi(_toggle_next, 0, toggle_state)
		else:
			_toggle_next = clampi(_toggle_next, 0, toggle_states)
		
		# Label is what happens *next*
		label = toggle_labels[_toggle_next]
	
	if interact_on_enter and ioe_scene:
		get_tree().change_scene_to_packed(ioe_scene)
	
	if flow_script:
		Cinema.queue(flow_script)
	#else:
		#prints(with.name, "interacted with", name, "FORM:", form)
