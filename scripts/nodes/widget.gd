class_name Widget extends Control

## Is only one allowed.
func is_exclusive() -> bool: return true
## Will autohide when non-hud widgits are displayed.
func is_hud() -> bool: return false
## Will pause the game when displayed.
func is_game_pauser() -> bool: return false
## Will stay visible when a cinematic is playing. (Captions, Choice Menu...)
func is_visible_in_cinematic() -> bool: return false

func close():
	pass

## Used by FlowPlayerGenerator.
func _cinematic_step(_gen: FlowPlayerGenerator, _step: Dictionary) -> void:
	pass
