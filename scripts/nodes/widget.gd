@abstract class_name Widget extends Control

var player_index := 0

## Is only one allowed.
func is_exclusive() -> bool: return true
## Will autohide when non-hud widgits are displayed.
func is_hud() -> bool: return false
## Will pause the game when displayed.
func is_pauser() -> bool: return false
## Will stay visible when a cinematic is playing. (Captions, Choice Menu...)
func is_visible_in_cinematic() -> bool: return false

func close() -> void:
	Controllers.get_player(player_index).hide_widgit(name)

func get_controller() -> ControllerPlayer:
	return Controllers.get_player(player_index)

func _unhandled_key_input(event: InputEvent) -> void:
	get_controller()._event = event

## Used by FlowPlayerGenerator to create keyframes.
func _cinematic_step(_gen: FlowPlayerGenerator, _step: Dictionary) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(&"exit"):
		(get_parent() as ControllerPlayer).hide_widgit(name)
