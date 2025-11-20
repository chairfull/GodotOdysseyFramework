class_name HumanoidSeat extends Pawn

@export var animation_mounted: StringName = &"Sitting_Idle"
@export var animation_unmounted: StringName = &"Standing"
var _dummy_timer := 0.0

func _controlled() -> void:
	super()
	_controller.camera_master.set_target(%camtarget, 0.5)

func _uncontrolled() -> void:
	super()
	_controller.camera_master.set_target(_controller.pawn_camera, 0.5)

func _rider_interacted(pawn: Pawn, form: Interactive.Form) -> void:
	super(pawn, form)
	if form == Interactive.Form.INTERACT_ALT:
		for ch: CharNode in Global.get_tree().get_nodes_in_group(&"npc"):
			if not ch.is_controlled():
				ch.move_to(%remote.global_position, self)

func _update_as_npc(delta: float) -> void:
	if not is_ridden(): return
	_dummy_timer += delta
	if _dummy_timer >= 5.0:
		_rider.behavior.blackboard.set_var(&"target_node", null)
		dismount_rider()

func _update_as_player(delta: float) -> void:
	super(delta)
	if _controller.is_action_pressed(&"exit"):
		dismount_rider()

func _gained_rider() -> void:
	super()
	_dummy_timer = 0.0
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
