@tool
extends Node

@export var choice_prefab: PackedScene
@export var caption: String: set=set_caption
@export var choices: Array[Dictionary]: set=set_choices

func set_caption(c: String):
	caption = c
	%caption.text = c

func set_choices(c: Array[Dictionary]):
	for child in %choices.get_children():
		%choices.remove_child(child)
	
	choices = c
	var index := 0
	for choice in choices:
		var btn := choice_prefab.instantiate()
		%choices.add_child(btn)
		btn.name = "choice_%s" % index
		btn.choice = choice
		index += 1

func _cinematic_step(gen: CinematicGenerator, step: Dictionary):
	var count: int = gen.get_state(&"menu_count", 0)
	gen.set_state(&"menu_count", count + 1)
	
	var t_caption := gen.add_track(self, "caption")
	var t_choices := gen.add_track(self, "choices")
	var t_visible := gen.add_track(self, "visible")
	# Start hidden.
	if count == 0:
		gen.add_key(t_visible, 0.0, false)
	gen.add_key(t_visible, gen.get_time(), true)
	if "caption" in step:
		gen.add_key(t_caption, gen.get_time(), step.caption)
	gen.add_key(t_choices, gen.get_time(), step.choices)
	gen.add_checkpoint()
	gen.add_time()
	gen.add_key(t_visible, gen.get_time(), false)
