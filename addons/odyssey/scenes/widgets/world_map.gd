class_name WorldMap2D extends Widget

@export var zoom_min := 0.1
@export var zoom_max := 4.0
var _move := Vector2.ZERO
var _zoom := 1.0
var _last_zoom := 1.0
var _tween_zooms: Tween

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	_move = get_controller().get_move_vector()

func _process(delta: float) -> void:
	var rect: Rect2 = %bounds.get_rect()
	var view := Global.view_size
	var half := view * .5
	var cam: Camera2D = %camera
	var pos: Vector2 = cam.get_screen_center_position() + _move * remap(_zoom, zoom_min, zoom_max, 1.0, 2.0) * delta * 120.0
	cam.global_position = pos
	
	cam.limit_left = rect.position.x
	cam.limit_top = rect.position.y
	cam.limit_right = rect.end.x
	cam.limit_bottom = rect.end.y
	
	_zoom += Input.get_axis(&"zoom_in", &"zoom_out") * _zoom * delta * 0.5
	_zoom = clampf(_zoom, zoom_min, zoom_max)
	cam.zoom = Vector2.ONE * _zoom
	
	for node in %zoom_1.get_children() + %zoom_2.get_children():
		node.scale = Vector2.ONE * (1.0 / _zoom) * 0.5
	
	var flip := 0.5
	
	if _zoom <= flip and _last_zoom > flip:
		_last_zoom = _zoom
		UTween.interp(self, func(x: float):
			%zoom_1.modulate.a = x
			%zoom_2.modulate.a = 1.0 - x
			, 0.25, &"_tween_zooms")
			
	elif _zoom > flip and _last_zoom <= flip:
		_last_zoom = _zoom
		UTween.interp(self, func(x: float):
			%zoom_1.modulate.a = 1.0 - x
			%zoom_2.modulate.a = x
			, 0.25, &"_tween_zooms")
