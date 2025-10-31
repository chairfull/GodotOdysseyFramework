class_name Controller extends Node

@export var index := 0 ## For multiplayer.
@export var controllable: Controllable: set=set_controllable

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_controllable(target: Controllable):
	if controllable == target: return
	if controllable:
		controllable.set_controller.call_deferred(null)
		_ended()
	controllable = target
	controllable.set_controller.call_deferred(self)
	_started.call_deferred()

func _started():
	pass

func _ended():
	pass
