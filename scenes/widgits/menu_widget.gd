@tool
class_name MenuWidget extends Widget

signal selected(choice: Dictionary)
signal selected_index(index: int)

@export var choices: Array[Dictionary]: set=set_choices

func get_choice_prefab() -> PackedScene:
	return preload("uid://bl1wu7da5ih3s")

func set_choices(c: Array) -> void:
	var buttons: TweeButtonList = %choice_parent
	buttons.clear()
	
	choices = c
	
	print("CHOICES ", choices)
	
	var index := 0
	var choice_prefab := get_choice_prefab()
	for choice in choices:
		var node := choice_prefab.instantiate()
		buttons.add_child(node)
		node.name = "choice_%s" % index
		node.choice = choice
		index += 1

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
