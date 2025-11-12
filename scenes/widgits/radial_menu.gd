@tool
class_name RadialMenu extends MenuWidget

enum InputMode { KEYBOARD, MOUSE, GAME_PAD }

@export var radius := 120.0 ## How far to keep buttons from each other.
@export var input_mode := InputMode.MOUSE
@export var mouse_deadzone: float = 5.0 # Pixels; ignore small movements
@export var mouse_sensitivity: float = 1.0 # Scale delta for snappier feel
@export_range(-PI, PI, 0.01, "radians_as_degrees") var rotation_offset := 0.0

var spacing: float:
	get: return TAU / float(choices.size())

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	var cont := get_controller()
	var buttons: TweeButtonList = %choice_parent
	
	if cont.is_action_pressed(&"interact"):
		select()
	
	match input_mode:
		InputMode.KEYBOARD:
			if cont.is_action_pressed(&"move_left"):
				buttons.hovered -= 1
			elif cont.is_action_pressed(&"move_right"):
				buttons.hovered += 1
		
		InputMode.MOUSE:
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
				buttons.hovered = closest_index
		
		InputMode.GAME_PAD:
			Global.warn("RadialMenu", "Gamepad not implemented.")

func set_choices(c: Array) -> void:
	super(c)
	
	var buttons: TweeButtonList = %choice_parent
	for i in choices.size():
		var angle := i * spacing + rotation_offset
		var distance := radius
		var node := buttons.buttons[i]
		node.position = Vector2(cos(angle), sin(angle)) * distance\
			- node.size * .5
