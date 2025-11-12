@tool
class_name MenuWidget extends Widget

signal selected(choice: Dictionary)
signal selected_index(index: int)

enum InputMode { KEYBOARD, MOUSE, GAME_PAD }

@export var choices: Array[Dictionary]: set=set_choices
@export var input_mode := InputMode.MOUSE
@export var mouse_deadzone: float = 5.0 # Pixels; ignore small movements
@export var mouse_sensitivity: float = 1.0 # Scale delta for snappier feel
var button_list: TweeButtonList:
	get: return %button_list

func get_choice_prefab() -> PackedScene:
	return preload("uid://bl1wu7da5ih3s")

func set_choices(c: Array) -> void:
	button_list.clear()
	choices = c
	
	print("CHOICES ", choices)
	
	var index := 0
	var choice_prefab := get_choice_prefab()
	for choice in choices:
		var node := choice_prefab.instantiate()
		button_list.add_child(node)
		node.name = "choice_%s" % index
		node.choice = choice
		index += 1

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	var cont := get_controller()
	
	if cont.is_action_pressed(&"interact"):
		select()
	
	match input_mode:
		InputMode.KEYBOARD: _input_keyboard(event)
		InputMode.MOUSE: _input_mouse(event)
		InputMode.GAME_PAD: _input_gamepad(event)

func _input_keyboard(_ev: InputEvent) -> void:
	var cont := get_controller()
	if cont.is_action_pressed(&"move_left") or cont.is_action_pressed(&"move_up"):
		button_list.hovered -= 1
	elif cont.is_action_pressed(&"move_right") or cont.is_action_pressed(&"move_down"):
		button_list.hovered += 1

func _input_mouse(_ev: InputEvent) -> void:
	pass

func _input_gamepad(_ev: InputEvent) -> void:
	pass # Global.warn("RadialMenu", "Gamepad not implemented.")

func select() -> void:
	var buttons: TweeButtonList = %choice_parent
	if buttons.select():
		print("closing")
		selected.emit(choices[buttons.hovered])
		selected_index.emit(buttons.hovered)
		Global.wait(0.5, close)

func _cinematic_step(gen: FlowPlayerGenerator, step: Dictionary) -> void:
	var menu_choices: Array[Dictionary]
	for substep in step.tabbed:
		if "tabbed" in substep:
			menu_choices.append({
				"text": substep.text,
				"anim": gen._add_branch_queued(substep.tabbed) })
	
	print("GENERATE ", menu_choices.size())
	
	var count: int = gen.get_state(&"menu_count", 0)
	gen.set_state(&"menu_count", count + 1)
	
	var t_choices := gen.add_track(self, "choices")
	var t_visible := gen.add_track(self, "visible")
	# Start hidden.
	if count == 0:
		gen.add_key(t_visible, 0.0, false)
	gen.add_key(t_visible, gen.get_time(), true)
	gen.add_key(t_choices, gen.get_time(), menu_choices)
	gen.add_checkpoint()
	gen.add_time()
	gen.add_key(t_visible, gen.get_time(), false)
