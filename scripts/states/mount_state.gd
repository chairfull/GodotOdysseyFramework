class_name MountState extends Node

var mount: Mount
var _controllable: Controllable

func _enter_tree() -> void:
	_controllable = mount.mounted_controllable
	
	if _controllable is Humanoid:
		var human: Humanoid = _controllable as Humanoid
		human.freeze()
		human.anim_travel(&"Sitting_Idle")
		var dir_from := human.direction
		var dir_to := mount.global_rotation.y
		var pos_from := human.global_position
		var pos_to := mount.global_position
		UTween.interp(_controllable, 
			func(x: float):
				_controllable.direction = lerp_angle(dir_from, dir_to, x)
				_controllable.global_position = lerp(pos_from, pos_to, x),
			0.5)

func _exit_tree() -> void:
	if _controllable is Humanoid:
		var human: Humanoid = _controllable as Humanoid
		human.anim_travel(&"Standing")
		Global.wait(0.5, human.unfreeze) ## Wait a smidge for animation to play.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"exit"):
		mount.unmount()
		get_viewport().set_input_as_handled()
