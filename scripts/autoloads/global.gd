extends Node

var view_size: Vector2:
	get: return Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

func wait(time: float, method: Callable) -> Signal:
	var sig := get_tree().create_timer(time).timeout
	sig.connect(method)
	return sig

func change_scene(next_scene: Variant):
	var trans := Assets.create_scene(&"transition", self)
	await trans.fade_out()
	if next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	elif next_scene is String:
		get_tree().change_scene_to_file(next_scene)
	await trans.fade_in()
	remove_child(trans)
	trans.queue_free()

func msg(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=cyan][%s][/color]" % head, txt, args, kwargs)

func warn(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=yellow][b][%s][/b][/color]" % head, txt, args, kwargs)

func err(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=red][b][%s][/b][/color]" % head, txt, args, kwargs)

func _msg(head: String, txt: Variant, args: Array, kwargs := {}):
	var lines := [head]
	if txt:
		lines.append("[color=%s]%s[/color]" % [Color.POWDER_BLUE.to_html(), txt])
	if args:
		var arg_lines := []
		var clrs := [Color.YELLOW.to_html(), Color.GOLD.to_html()]
		for i in args.size():
			arg_lines.append("[color=#%s]%s[/color]" % [clrs[0 if i % 2 == 0 else 1], args[i]])
		lines.append(", ".join(arg_lines))
	if kwargs:
		var keys := []
		for key in kwargs:
			keys.append("%s:[color=yellow][i]%s[/i][/color]" % [key, kwargs[key]])
		lines.append(" ".join(keys))
	print_rich(" ".join(lines))
