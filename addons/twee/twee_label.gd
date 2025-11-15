@tool
class_name TweeLabel extends TweeNode

@export var text: String: set=set_text
@export_storage var _chars: Array[TweeLabelChar]
@export_storage var bounds: Rect2
var _time := 0.0
@export_tool_button("Populate") var _tool_populate := func():
	_chars.clear()
	for i in 10:
		var cd := TweeLabelChar.new()
		_chars.append(cd)
		cd.index = i
		
	Log.grad("All right we did it, woohoo!!!")

func _ready() -> void:
	for t in twees:
		t.target_property = ^"_chars"
	super()
	for t in twees:
		print(t.get_twee_script(self).source_code)
	Input.set_mouse_mode.call_deferred(Input.MOUSE_MODE_VISIBLE)

func _twee_changed() -> void:
	super()
	#reload.call_deferred()
	print("Twee changed...")

func set_text(t: String) -> void:
	text = t
	_chars.clear()
	bounds = Rect2()
	
	var font := ThemeDB.fallback_font
	var fsize := 32
	var ascent := font.get_ascent(fsize)
	var descent := font.get_descent(fsize)
	var h := ascent + descent
	var pos := Vector2.ZERO
	
	for i in text.length():
		var cd := TweeLabelChar.new()
		_chars.append(cd)
		cd.index = i
		cd.text = text[i]
		cd.trans = Transform2D.IDENTITY
		cd.origin = pos + Vector2(0.0, ascent - descent)
		cd.rect = Rect2(pos, Vector2(
			font.get_string_size(text[i], HORIZONTAL_ALIGNMENT_CENTER, -1, fsize).x,
			ascent
		))
		bounds = bounds.merge(cd.rect)
		
		pos.x += cd.rect.size.x
		cd.reset_seed()
	
	# Resize label.
	var con := as_control()
	var maximum := Vector2(maxf(bounds.size.x, con.size.x), maxf(bounds.size.y, con.size.y))
	con.set_size.call_deferred(maximum)
	con.set_custom_minimum_size.call_deferred(bounds.size)

func _process(delta: float) -> void:
	_time += delta
	var canvas: CanvasItem = self as Object as CanvasItem
	canvas.queue_redraw()

func _draw() -> void:
	var canvas: CanvasItem = self as Object as CanvasItem
	var font := ThemeDB.fallback_font
	var fsize := 32
	var ascent := Vector2(0.0, font.get_ascent(fsize))
	
	canvas.draw_rect(bounds, Color.RED, false, 2, true)
	
	for item in _chars:
		if item.text == " ": continue
		canvas.draw_set_transform_matrix(Transform2D.IDENTITY)
		canvas.draw_rect(item.rect.grow(-2.0), Color(Color.CYAN, 0.2), true, -1, true)
	
	for item in _chars:
		if item.text == " ": continue
		var baseline := Vector2(0.0, font.get_ascent(fsize))
		var half_size := item.rect.size * .5
		item.rotation = sin(_time) * .2
		var basis_only := Transform2D(item.trans.x, item.trans.y, Vector2.ZERO)
		var desired_center := (item.origin + item.off - ascent) + Vector2(baseline.x, 0) + half_size
		var draw_mtx := Transform2D.IDENTITY.translated(desired_center) * basis_only * Transform2D.IDENTITY.translated(-half_size)
		canvas.draw_set_transform_matrix(draw_mtx)
		canvas.draw_string(font, ascent, item.text, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize, item.color)
	
