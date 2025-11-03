class_name HumanoidState extends Node

var humanoid: Humanoid
var _controller: Controller
var _controller_player: ControllerPlayer

func is_player() -> bool:
	return _controller is ControllerPlayer

func _enter_tree() -> void:
	_controller = humanoid.controller
	if is_player():
		_controller_player = _controller
