class_name Controller extends Node3D

@export var index := 0 ## For multiplayer.
@export var controllable: Node3D: set=set_controllable, get=get_controllable

func _init() -> void:
	add_to_group(&"Controller")

func set_controllable(target: Node3D):
	if target.is_controlled() and target.get_controller() != self:
		controllable.uncontrolled.emit()
		_ended()
	#controllable = convert(target, TYPE_OBJECT)
	controllable.controlled.emit()
	_started.call_deferred()

func get_controllable() -> Node3D:
	var parent := get_parent()
	if parent.has_method(&"get_controller"):
		return parent
	return null

func _started():
	pass

func _ended():
	pass

static func get_move_vector() -> Vector2:
	return Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
