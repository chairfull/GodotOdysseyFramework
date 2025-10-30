@tool class_name Interactive extends Area3D

signal toggled()
signal toggled_on()
signal toggled_off()
signal hold_started()
signal hold_percent(amnt: float)
signal hold_ended()
signal interacted(controllable: Controllable, form: Form)
signal mounted(controller: Controllable)
signal unmounted(controller: Controllable)

enum Form { INTERACT, ENTERED, EXITED }
@export var label: String = "Interact"
var can_interact := func(_controllable: Controllable): return true

@export_group("Toggleable")
@export var toggle_states := 0 ## 0 == no toggle. 1 = on/off.
@export var toggle_state := 0

@export_group("Holdable")
@export var hold_time := 0.0 ## How many seconds to hold interact. Useful for turnwheels.
@export var hold_instant_reset := true
@export var hold_increase_scale := 1.0
@export var hold_decrease_scale := 1.0
var _held := false
var _held_time := 0.0
var _held_controllable: Controllable
var _held_form: Form

@export_group("Enterable & Exitable")
@export var interact_on_enter := false ## Interaction occurs when object enters.
@export var interact_on_exit := false ## Interaction occurs when object leaves.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var ioe_expression: String ## Expression to test if interact_on_enter == true.
@export var ioe_delay := 0.1 ## Slight time delay, so it's not instant. If no longer inside, this cancels interaction.
@export var ioe_scene: PackedScene ## A scene to swap to if interaction occurs.

@export_group("Mountable")
@export var mountable := false
@export var mount_anim := &"" ## Animation to play when mounting.
@export var mount_target: Node3D: ## Object will be aligned to this.
	get: return mount_target if mount_target else self
var mounted_controllable: Controllable: set=mount

func _init() -> void:
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func _ready() -> void:
	body_entered.connect(_entered)
	body_exited.connect(_exited)
	set_process(false)

func is_toggled() -> bool: return toggle_state >= 1
func is_toggleable() -> bool: return toggle_states >= 1

func is_mounted() -> bool:
	return mounted_controllable != null

func mount(obj: Controllable):
	if obj == null:
		if is_mounted():
			unmount()
		return
	
	mounted_controllable = obj
	
	if mounted_controllable is Humanoid and mount_anim:
		var human: Humanoid = mounted_controllable as Humanoid
		human.freeze()
		human.anim_travel(mount_anim)
		var dir_from := human.direction
		var dir_to := mount_target.global_rotation.y
		var pos_from := human.global_position
		var pos_to := mount_target.global_position
		UTween.interp(mounted_controllable, 
			func(x: float):
				mounted_controllable.direction = lerp_angle(dir_from, dir_to, x)
				mounted_controllable.global_position = lerp(pos_from, pos_to, x),
			0.5)
	
	mounted.emit(mounted_controllable)
	
func unmount():
	if not is_mounted(): return
	
	if mounted_controllable is Humanoid and mount_anim:
		mounted_controllable.unfreeze()
		mounted_controllable.anim_travel(&"Standing")

	unmounted.emit(mounted_controllable)
	mounted_controllable = null

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

func interact(controllable: Controllable, form := Form.INTERACT):
	if not can_interact.call(controllable): return
	if hold_time == 0:
		_interacted(controllable, form)
	else:
		_held = true
		_held_controllable = controllable
		_held_form = form
		hold_started.emit()
		set_process(true)

## Cancel the interaction.
## Only used when hold_time != 0.0
func cancel(controllable: Controllable):
	if _held and controllable == _held_controllable:
		_held = false
		_held_controllable = null
		hold_ended.emit()

func _process(delta: float) -> void:
	if _held:
		_held_time += delta * hold_increase_scale
		if _held_time >= hold_time:
			set_process(false)
			_held_time = hold_time
			hold_percent.emit(1.0)
			_interacted(_held_controllable, _held_form)
			_held_controllable = null
		else:
			hold_percent.emit(remap(_held_time, 0.0, hold_time, 0.0, 1.0))
	
	else:
		if hold_instant_reset:
			_held_time = 0.0
		else:
			_held_time -= delta * hold_decrease_scale
		if _held_time <= 0.0:
			set_process(false)
			_held_time = 0.0
			hold_percent.emit(0.0)
		else:
			hold_percent.emit(remap(_held_time, 0.0, hold_time, 0.0, 1.0))

func _interacted(controllable: Controllable, form: Form) -> void:
	interacted.emit(controllable, form)
	
	if is_toggleable():
		toggle_state = wrapi(toggle_state + 1, 0, toggle_states)
		toggled.emit()
		if is_toggled():
			toggled_on.emit()
		else:
			toggled_off.emit()
	
	if mountable:
		mount(controllable)
	
	if interact_on_enter and ioe_scene:
		get_tree().change_scene_to_packed(ioe_scene)
