@tool
extends Node

@export var text: String: set=set_text

func set_text(t: String):
	%label.text = t

func _cinematic_step(gen: FlowPlayerGenerator, step: Dictionary):
	var speaker := ""
	var caption := ""
	match step.type:
		FlowToken.KEYV:
			speaker = step.key
			caption = step.val
		FlowToken.TEXT:
			caption = step.text
		
	if speaker:
		caption = "%s: %s" % [speaker, caption]
	else:
		caption = caption
	
	var caption_count: int = gen.get_state(&"caption_count", 0)
	gen.set_state(&"caption_count", caption_count + 1)
	var t_visible := gen.add_track(self, "visible")
	var t_text := gen.add_track(self, "text")
	if caption_count == 0:
		gen.add_key(t_text, 0, "")
	gen.add_key(t_visible, gen.get_time(), true)
	gen.add_key(t_text, gen.get_time(), caption)
	gen.add_checkpoint()
	gen.add_time()
	gen.add_key(t_visible, gen.get_time(), false)
