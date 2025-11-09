class_name PStateRiderAgentPlayer extends PStateRider
## Player Agent is riding that Pawn.

@export var widget: StringName ## If player, scene added to hud.
var _widget: Widget

func _accept_controller(con: Controller) -> bool:
	return con is ControllerPlayer

func _enable() -> void:
	super()
	if widget:
		_widget = get_player_controller().show_widgit(widget)

func _disable() -> void:
	super()
	if _widget:
		get_player_controller().hide_widgit(widget)

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()
