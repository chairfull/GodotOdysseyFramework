@tool
class_name Interactive extends Area3D

signal interacted()

@export var label: String = "Interact"
var can_interact := func(_controllable: Controllable): return true

func _init() -> void:
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func interact(controllable: Controllable):
	if not can_interact.call(controllable): return
	interacted.emit(controllable)
	_interacted(controllable)

func _interacted(_controllable: Controllable) -> void:
	pass
