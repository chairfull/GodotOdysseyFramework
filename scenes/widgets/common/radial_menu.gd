@tool
class_name RadialMenu extends MenuWidget

@export var radius := 120.0 ## How far to keep buttons from each other.
@export_range(-PI, PI, 0.01, "radians_as_degrees") var rotation_offset := 0.0

var spacing: float:
	get: return TAU / float(choices.size())

func _input_mouse(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative * mouse_sensitivity 
		if delta.length() < mouse_deadzone:
			return
		var mouse_dir := delta.normalized()
		var mouse_angle := mouse_dir.angle()
		var closest_index := 0
		var min_diff := INF
		for i in choices.size():
			var angle := i * spacing + rotation_offset
			var diff := absf(angle_difference(mouse_angle, angle))
			if diff < min_diff:
				min_diff = diff
				closest_index = i
		button_list.hovered = closest_index

func set_choices(c: Array) -> void:
	super(c)
	
	for i in choices.size():
		var angle := i * spacing + rotation_offset
		var distance := radius
		var node := button_list.buttons[i]
		node.position = Vector2(cos(angle), sin(angle)) * distance\
			- node.size * .5
