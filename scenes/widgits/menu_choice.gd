@tool
class_name MenuChoiceButton extends TweeButton

@export var choice: Dictionary: set=set_choice

#func _ready() -> void:
	#(%margin as MarginContainer).resized.connect(_resized)
#
func _resized():
	var btn := as_control()
	#btn.size.y = %margin.size.y
	btn.pivot_offset = btn.size * .5

func set_choice(c):
	choice = c
	
	%label.size = Vector2.ZERO
	%label.text = choice.get(&"text", "NO_TEXT")
	
	if &"icon" in choice:
		%icon.texture = load(choice.icon)
	
	_resized()
