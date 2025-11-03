class_name MountState extends Node3D


@export var anim_enter := &"Sitting_Idle"
@export var anim_exit := &"Standing"
@export var attach_on_enter := true ## Should controllable be attached?
@export var align_position := true ## Animation controllable position.
@export var align_rotation := true ## A
var _mount: Mount
var _controllable: Controllable
var _huds: Array[Node]

func get_controller() -> Controller:
	return _mount.controller

func get_player_controller() -> ControllerPlayer:
	return _mount.controller

func is_player() -> bool:
	return _mount.controller is ControllerPlayer

func _enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	_mount = get_parent()
	_controllable = _mount.mounted_controllable
	
	if _controllable is Humanoid:
		var human: Humanoid = _controllable as Humanoid
		human.freeze()
		if anim_enter:
			human.trigger_animation.emit(anim_enter)
		if align_position or align_rotation:
			var dir_from := human.direction
			var dir_to := _mount.global_rotation.y
			var pos_from := human.position
			var pos_to := Vector3.ZERO
			UTween.interp(human, 
				func(x: float):
					if align_rotation:
						human.direction = lerp_angle(dir_from, dir_to, x)
					if align_position:
						human.position = lerp(pos_from, pos_to, x),
				0.5)

func _disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
	if _controllable is Humanoid:
		var human: Humanoid = _controllable as Humanoid
		human.fix_direction()
		human.direction = _mount.global_rotation.y
		if anim_exit:
			human.trigger_animation.emit(anim_exit)
			Global.wait(0.8, human.unfreeze) ## Wait a smidge for animation to play.
		else:
			human.unfreeze()
		
		# TODO:
		for hud in _huds:
			hud.queue_free()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"exit"):
		_mount.unmount()
		get_viewport().set_input_as_handled()
