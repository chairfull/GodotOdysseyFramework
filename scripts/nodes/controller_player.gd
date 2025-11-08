class_name ControllerPlayer extends Controller

signal view_state_changed()
signal focus_exited(con: Control)
signal focus_entered(con: Control)

enum ViewState { None, FirstPerson, ThirdPerson, TopDown }

@onready var viewport_container: ControllerPlayer = %viewport_container
@onready var fps_viewport_container: SubViewportContainer = %fps_viewport_container
@onready var viewport: SubViewport = %viewport
@onready var camera_master: CameraMaster = %camera_master
var input_remap: Dictionary[StringName, StringName] # TODO: Move to some global area?
var _widgits: Dictionary[StringName, Widget]
var _event: InputEvent
var _focused_control: Control

var view_state := ViewState.FirstPerson:
	set(vs):
		view_state = vs
		view_state_changed.emit()
		prints(name, view_state_changed.get_connections(), pawn)

func hide_fps_viewport():
	UTween.parallel(fps_viewport_container, { "modulate:a": 0.0 }, 0.2)\
		.finished.connect(func(): fps_viewport_container.visible = false)

func show_fps_viewport():
	fps_viewport_container.visible = true
	UTween.parallel(fps_viewport_container, { "modulate:a": 1.0 }, 0.2)

func grab_control_focus(c: Control):
	c.grab_focus()

func get_move_vector() -> Vector2:
	return Input.get_vector(
		input_remap.get(&"move_left", &"move_left"),
		input_remap.get(&"move_right", &"move_right"),
		input_remap.get(&"move_forward", &"move_forward"),
		input_remap.get(&"move_backward", &"move_backward"))

func get_move_vector_camera() -> Vector2:
	var dir := camera_master.global_rotation.y
	return get_move_vector().rotated(-dir)

func is_widgit_visible(id: StringName) -> bool:
	return ("hud_" + id) in _widgits

func toggle_widgit(id: StringName) -> Node:
	if is_widgit_visible(id):
		hide_widgit(id)
		return null
	else:
		return show_widgit(id)

func show_widgit(id: StringName, props := {}) -> Widget:
	var hud_id := "hud_" + id
	var widgit: Widget = _widgits.get(hud_id)
	if not widgit:
		widgit = Assets.create_prefab(hud_id, self, props)
		_widgits[hud_id] = widgit
	return widgit

func hide_widgit(id: StringName) -> bool:
	var hud_id := "hud_" + id
	var widgit: Widget = _widgits.get(hud_id)
	if widgit:
		remove_child(widgit)
		widgit.queue_free()
		_widgits.erase(hud_id)
		return true
	return false

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return _event.is_action_pressed(input_remap.get(action, action), allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return _event.is_action_released(action, exact_match)

func _unhandled_input(event: InputEvent) -> void:
	if name != "player_1": return
	_event = event
	
	if _focused_control:
		var next: Control
		if is_action_pressed(&"move_left"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_LEFT)
			if not next: next = _focused_control.find_prev_valid_focus()
		elif is_action_pressed(&"move_right"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_RIGHT)
			if not next: next = _focused_control.find_next_valid_focus()
		elif is_action_pressed(&"move_forward"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_TOP)
			if not next: next = _focused_control.find_prev_valid_focus()
		elif is_action_pressed(&"move_down"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_BOTTOM)
			if not next: next = _focused_control.find_next_valid_focus()
		if next:
			if _focused_control: focus_exited.emit(_focused_control)
			_focused_control = next
			if _focused_control: focus_entered.emit(_focused_control)
			get_viewport().input_as_handled()
	
	if is_action_pressed(&"toggle_first_person", false, true):
		print("first person")
		view_state = ViewState.FirstPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_third_person", false, true):
		print("third person")
		view_state = ViewState.ThirdPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_top_down", false, true):
		print("top down")
		view_state = ViewState.TopDown
		get_viewport().set_input_as_handled()
