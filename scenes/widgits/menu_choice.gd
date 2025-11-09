extends Node

@export var choice: Dictionary: set=set_choice

func set_choice(c):
	choice = c
	var label: RichTextLabel = convert(self, TYPE_OBJECT)
	label.text = choice.get("text", "NO_TEXT")
