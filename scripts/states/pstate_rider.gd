@abstract class_name PStateRider extends PawnState
## PawnState that enables when someone is riding.

@export var pawn_as_remote := true ## Attaches rider to Pawn using a RemoteTransform3D.
@export_node_path("Node3D") var rider_remote: NodePath ## Attaches rider here using a RemoteTransform3D.
@export var rider_update_position := true
@export var rider_update_rotation := true
@export var rider_update_scale := false
var _rider: Node3D
var _remote: RemoteTransform3D

@export var play_animation := true
@export var animation_enter := &"Sitting_Idle"
@export var animation_exit := &"Standing"
@export var tween_position := true ## Animation controllable position.
@export var tween_rotation := true ## A
@export var tween_time := 0.5

@export var cinematic: FlowScript ## Cinematic to play.
@export var eject_on_cinematic_finished := false ## TODO:

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.rider_mounted.connect(_rider_mounted)
	pawn.rider_unmounted.connect(_rider_unmounted)

func kick_rider():
	pawn.set_rider(null)

func _rider_mounted(rider: Pawn) -> void:
	if not _accept_controller(rider.controller): return
	
	_rider = rider.node
	_controller = rider.controller
	_rider.freeze()
	
	if pawn_as_remote or rider_remote:
		
		_remote = RemoteTransform3D.new()
		if pawn_as_remote:
			pawn.add_child(_remote)
		else:
			pawn.get_node(rider_remote).add_child(_remote)
		
		if tween_position:
			_remote.global_position = _rider.global_position
		if tween_rotation:
			_remote.global_rotation.y = _rider.direction
			_rider.direction = 0.0
		
		_remote.name = _rider.name + "_remote"
		_remote.update_position = rider_update_position
		_remote.update_rotation = rider_update_rotation
		_remote.update_scale = rider_update_scale
		_remote.remote_path = _rider.get_path()
	
	_enable()

func _rider_unmounted(rider: Pawn) -> void:
	if _rider != rider.node: return
	print("Rider unmounted...")
		
	if _remote:
		_remote.get_parent().remove_child(_remote)
		_remote.queue_free()
		_remote = null
	
	_disable()
	
	_rider.unfreeze()
	_rider = null
	_controller = null

func _enable() -> void:
	super()
	
	if cinematic:
		Cinema.queue(cinematic)
	
	if not _rider is Humanoid: return
	var humanoid: Humanoid = _rider
	
	if play_animation and animation_enter:
		humanoid.trigger_animation.emit(animation_enter)
	
	if tween_position or tween_rotation:
		if _remote:
			var dir_from := _remote.rotation.y
			var pos_from := _remote.position
			UTween.interp(_remote, 
				func(x: float):
					if tween_rotation:
						_remote.rotation.y = lerp_angle(dir_from, 0.0, x)
					if tween_position:
						_remote.position = lerp(pos_from, Vector3.ZERO, x),
				tween_time)
		else:
			var dir_from := humanoid.global_rotation.y
			var pos_from := humanoid.global_position
			UTween.interp(humanoid, 
				func(x: float):
					if tween_rotation:
						humanoid.direction = lerp_angle(dir_from, 0.0, x)
					if tween_position:
						humanoid.position = lerp(pos_from, Vector3.ZERO, x),
				tween_time)

func _disable() -> void:
	super()
	if not _rider is Agent: return
	var agent: Agent = _rider
	
	if play_animation and animation_exit:
		agent.trigger_animation.emit(animation_exit)
	
	if pawn.rider_unmount_area:
		var from_pos := agent.global_position
		var from_rot := agent.global_rotation.y
		var to_pos := pawn.rider_unmount_area.global_position
		var to_rot := pawn.rider_unmount_area.global_rotation.y
		agent.fix_direction()
		UTween.interp(agent,
			func(x: float):
				agent.global_position = lerp(from_pos, to_pos, x)
				agent.global_rotation.y = lerp_angle(from_rot, to_rot, x)
				, 0.5).finished.connect(agent.fix_direction)
	else:
		agent.fix_direction()
