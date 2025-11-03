extends MountState

var _root: Node3D
var _angle := 0.0

func _enable() -> void:
	super()
	_root = _mount.get_parent()

func _process(delta: float) -> void:
	if is_player():
		var vec := get_player_controller().get_move_vector()
		_angle -= vec.x * 2.0 * delta
	_root.rotation.y = lerp_angle(_root.rotation.y, _angle, delta * 10.0)
