class_name PStateRiderAgentPlayer extends PStateRider
## Player Agent is riding that Pawn.

@export var hud: StringName ## If player, scene added to hud.
var _hud: Node

func _accept_controller(con: Controller) -> bool:
	return con is ControllerPlayer

func _enable() -> void:
	super()
	if hud:
		_hud = get_player_controller().show_hud(hud)

func _disable() -> void:
	super()
	if _hud:
		get_player_controller().hide_hud(hud)

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()
