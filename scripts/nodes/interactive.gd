@tool @icon("res://addons/odyssey/icons/interactive.svg")
class_name Interactive extends Area3D

signal interacted(pawn: Pawn, form: Form)
signal highlight_changed()

enum Form { INTERACT, INTERACT_ALT, ENTERED, EXITED }
enum Highlight { NONE, FOCUSED }

@export var label: String = "Object"
@export var interact_label: String = "[E] Interact"
@export var interact_alt_label: String = "[Z] Interact"
@export var label_world_space_offset := Vector3.ZERO
@export var humanoid_lookat_offset := Vector3.ZERO
@export var components: Array[InteractiveRes]
var can_interact := func(_pawn: Pawn): return true
var can_interact_alt := func(_pawn: Pawn): return true
var _interacting_pawn: Pawn
var _interacting_form: Form

@export var enabled := true:
	get: return monitorable
	set(d): monitorable = d

@export var highlight := Highlight.NONE:
	set(h):
		highlight = h
		highlight_changed.emit()

func _init() -> void:
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func _ready() -> void:
	#body_entered.connect(_entered)
	#body_exited.connect(_exited)
	set_process(false)

#func _entered(body: Node3D):
	#if body is Pawn:
		#interaction_pressed(body, Form.ENTERED)
#
#func _exited(body: Node3D):
	#if body is Pawn:
		#interaction_released(body)
		#interaction_pressed(body, Form.EXITED)

func interaction_pressed(pawn: Pawn, form := Form.INTERACT):
	if _interacting_pawn:
		return
	
	_interacting_pawn = pawn
	_interacting_form = form
	
	for comp in components:
		if comp.active:
			comp._interaction_pressed(self)
	
	set_process(true)

func interaction_released(pawn: Pawn) -> void:
	if pawn != _interacting_pawn:
		return
	
	for comp in components:
		comp._interaction_released(self)
	
	_interacting_pawn = null
	set_process(false)

func _process(delta: float) -> void:
	var blocked := false
	for comp in components:
		if comp.active and comp._process(self, delta):
			blocked = true
	
	if not blocked:
		for comp in components:
			comp._interact(self)
		set_process(false)
		interacted.emit(_interacting_pawn, _interacting_form)
