extends Node

func _ready() -> void:
	for button in Overrides.main_menu_options:
		var btn := Button.new()
		btn.name = button.id
		btn.text = button.text
		if &"pressed" in button:
			btn.pressed.connect(button.pressed)
		%buttons.add_child(btn)
