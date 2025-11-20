extends Widget

func _ready() -> void:
	State.add_pauser(self)
	%menu.set_choices([
		{ text="Continue", call=close },
		{ text="Settings", call=show_widget.bind(&"settings") },
		{ text="Save", call=show_widget.bind(&"save_menu") },
		{ text="Load", call=show_widget.bind(&"load_menu") },
		{ text="Quit", call=show_widget.bind(&"quit_popup") },
	])

func _unhandled_input(_event: InputEvent) -> void:
	if is_action_pressed(&"pause"):
		handle_input()
		close()

func _closed(returned: Variant) -> void:
	super(returned)
	State.remove_pauser(self)
