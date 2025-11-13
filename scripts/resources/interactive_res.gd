class_name InteractiveRes extends Resource

@export var active := true
@export var form := Interactive.Form.INTERACT

func _interaction_pressed(_inter: Interactive) -> void:
	pass

func _interaction_released(_inter: Interactive) -> void:
	pass

func _interact(_inter: Interactive) -> void:
	pass

## Return false if blocking.
func _process(_inter: Interactive, _delta: float) -> bool:
	return true
