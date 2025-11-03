@tool
extends Node

@export var text: String: set=set_text

func set_text(t: String):
	%label.text = t

func _cinematic_step(gen: CinematicGenerator, step: Dictionary):
	var caption: String
	if "from" in step:
		caption = "%s: %s" % [step.from, step.text]
	else:
		caption = step.text
	#match step.type:
		#FlowScriptParser.TYPE_KEYV: caption = "%s: %s" % [step.key, step.val]
		#"cap": caption = step.text
	
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
