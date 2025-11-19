class_name HumanoidSeat extends Pawn

@export var animation_mounted: StringName = &"Sitting_Idle"
@export var animation_unmounted: StringName = &"Standing"

func _controlled() -> void:
	super()
	_controller.camera_master.set_target(%camtarget, 0.5)

func _uncontrolled() -> void:
	super()
	_controller.camera_master.set_target(_controller.pawn_camera, 0.5)

func _gained_rider() -> void:
	super()
	var human: Humanoid = _rider
	human.trigger_animation.emit(animation_mounted)
	human.freeze()
	%remote.set_node(_rider)

func _lost_rider() -> void:
	super()
	var human: Humanoid = _rider
	%remote.set_node(null)
	human.unfreeze()
	human.trigger_animation.emit(animation_unmounted)

func _update_as_controlled(delta: float) -> void:
	super(delta)
	if _controller.is_action_pressed(&"exit"):
		dismount_rider()
