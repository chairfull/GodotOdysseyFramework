class_name Controller extends Node

@export var index := 0 ## For multiplayer.
@export var controllable: Controllable: set=set_controllable

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_controllable(target: Controllable):
	if target.is_controlled() and target.get_controller() != self:
		controllable._control_ended()
		_ended()
	controllable = target
	controllable._control_started()
	_started.call_deferred()

func _started():
	pass

func _ended():
	pass
