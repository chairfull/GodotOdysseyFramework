@tool
extends Node

var choice_prefab: PackedScene = preload("res://scenes/prefabs/ui/hud_menu_choice.tscn")
@export var caption: String: set=set_caption
@export var choices: Array: set=set_choices

func set_caption(c: String):
	caption = c
	%caption.text = c

func set_choices(c: Array):
	for child in %choices.get_children():
		%choices.remove_child(child)
	
	choices = c
	var index := 0
	for choice in choices:
		var btn := choice_prefab.instantiate()
		%choices.add_child(btn)
		btn.name = "choice_%s" % index
		btn.text = choice.text
		btn.choice = choice
		index += 1

func _cinematic_step(gen: CinematicGenerator, step: Dictionary):
	#print("MENU ", step)
	
	var menu_caption: String
	var menu_choices: Array[Dictionary]
	for substep in step.tabbed:
		if "tabbed" in substep:
			menu_choices.append({
				"text": substep.text,
				"anim": gen.add_branch_queued(substep.tabbed) })
		else:
			menu_caption = substep.text
	
	var count: int = gen.get_state(&"menu_count", 0)
	gen.set_state(&"menu_count", count + 1)
	
	var t_caption := gen.add_track(self, "caption")
	var t_choices := gen.add_track(self, "choices")
	var t_visible := gen.add_track(self, "visible")
	# Start hidden.
	if count == 0:
		gen.add_key(t_visible, 0.0, false)
	gen.add_key(t_visible, gen.get_time(), true)
	if menu_caption:
		gen.add_key(t_caption, gen.get_time(), menu_caption)
	gen.add_key(t_choices, gen.get_time(), menu_choices)
	gen.add_checkpoint()
	gen.add_time()
	gen.add_key(t_visible, gen.get_time(), false)
