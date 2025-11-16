class_name OSAppVisual extends Control

enum State {
	MINIMISED,
	WINDOWED,
	FULL_WINDOWED,
	FULL_SCREEN
}

@export var app: OSApp
@export var app_bar_icon: OSAppBarIcon
@onready var windowed_size := size
@onready var windowed_position := position
@export var title: String:
	set(t):
		title = t
		%title.text
var desktop: OSDesktop:
	get: return owner
var state := State.WINDOWED
var _dragging_position := false
var _dragging_size := false

func _ready() -> void:
	%drag_position.gui_input.connect(_drag_position_input)
	%drag_size.gui_input.connect(_drag_size_input)
	%minimize.pressed.connect(_pressed_minimize)
	%full_screen.pressed.connect(_pressed_full_screen)
	%close.pressed.connect(_pressed_close)

func _pressed_minimize() -> void:
	pass

func _pressed_full_screen() -> void:
	if state == State.FULL_WINDOWED:
		state = State.WINDOWED
		size = windowed_size
		position = windowed_position
		
	elif state == State.WINDOWED:
		state = State.FULL_WINDOWED
		windowed_size = size
		windowed_position = position
		position = Vector2.ZERO
		size = get_parent_control().size
		clamp_rect()

func _pressed_close() -> void:
	if app_bar_icon:
		app_bar_icon.queue_free()
	queue_free()

func _drag_size_input(ev: InputEvent) -> void:
	if ev is InputEventMouseButton:
		if ev.button_index == MOUSE_BUTTON_LEFT:
			if ev.is_pressed():
				_dragging_size = true
				get_viewport().set_input_as_handled()
			elif ev.is_released():
				_dragging_size = false
				get_viewport().set_input_as_handled()
	elif ev is InputEventMouseMotion:
		if _dragging_size:
			size += ev.relative
			clamp_rect()
			get_viewport().set_input_as_handled()

func _drag_position_input(ev: InputEvent) -> void:
	if ev is InputEventMouseButton:
		if ev.button_index == MOUSE_BUTTON_LEFT:
			if ev.is_pressed():
				_dragging_position = true
				get_viewport().set_input_as_handled()
			elif ev.is_released():
				_dragging_position = false
				get_viewport().set_input_as_handled()
	elif ev is InputEventMouseMotion:
		if _dragging_position:
			position += ev.relative
			clamp_rect()
			get_viewport().set_input_as_handled()

func clamp_rect() -> void:
	var p := get_parent_control()
	global_position.x = clampf(global_position.x, p.global_position.x, p.size.x - size.x)
	global_position.y = clampf(global_position.y, p.global_position.y, p.size.y - size.y)
