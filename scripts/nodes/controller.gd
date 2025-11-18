class_name Controller extends Node

signal view_state_changed()
signal focus_exited(con: Control)
signal focus_entered(con: Control)

enum ViewState { None, FirstPerson, ThirdPerson, TopDown }

@export var index := 0 ## For multiplayer.
@export var pawn: Pawn: set=set_pawn
@onready var viewport_container: SubViewportContainer = %viewport_container
@onready var fps_viewport_container: SubViewportContainer = %fps_viewport_container
@onready var viewport: SubViewport = %viewport
@onready var camera_master: CameraMaster = %camera_master
@export var pawn_camera: CameraTarget
var input_remap: Dictionary[StringName, StringName] # TODO: Move to some global area?
var _widgets: Dictionary[StringName, Widget]
var _focused_control: Control

var view_state := ViewState.FirstPerson:
	set(vs):
		view_state = vs
		view_state_changed.emit()
		prints(name, view_state_changed.get_connections(), pawn)

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func is_first_person() -> bool: return view_state == ViewState.FirstPerson
func is_third_person() -> bool: return view_state == ViewState.ThirdPerson

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

func _get_widget_id(id: StringName) -> StringName:
	if id.begins_with("uid://"):
		return ResourceUID.uid_to_path(id).get_basename().get_file()
	return id

func is_widget_visible(id: StringName) -> bool:
	return _get_widget_id(id) in _widgets

func toggle_widget(id: StringName, props := {}) -> Node:
	if is_widget_visible(id):
		hide_widget(id)
		return null
	else:
		return show_widget(id, props)

func show_widget(id: StringName, props := {}, transitioned := false) -> Widget:
	id = _get_widget_id(id)
	var widget: Widget = _widgets.get(id)
	if not is_widget_visible(id):
		widget = Assets.create_scene(id, self, props)
		if widget.is_pauser():
			State.add_pauser(widget)
		_widgets[id] = widget
	if transitioned:
		widget.show_transitioned()
	return widget

func hide_widget(id: StringName, returned: Variant = null) -> bool:
	id = _get_widget_id(id)
	var widget: Widget = _widgets.get(id)
	if widget:
		if widget.is_pauser():
			State.remove_pauser(widget)
		widget._closed(returned)
		widget.queue_free()
		remove_child(widget)
		_widgets.erase(id)
		return true
	push_error("No open widget: %s" % [id])
	return false

func is_action_pressed(action: StringName, exact_match := false) -> bool:
	return Input.is_action_just_pressed(input_remap.get(action, action), exact_match)
	#return _event.is_action_pressed(input_remap.get(action, action), allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return Input.is_action_just_released(input_remap.get(action, action), exact_match)
	#return _event.is_action_released(action, exact_match)

func _unhandled_input(event: InputEvent) -> void:
	if name != "player_1": return
	#_event = event
	
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
	
	if is_action_pressed(&"toggle_first_person", true):
		print("first person")
		view_state = ViewState.FirstPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_third_person", true):
		print("third person")
		view_state = ViewState.ThirdPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_top_down", true):
		print("top down")
		view_state = ViewState.TopDown
		get_viewport().set_input_as_handled()

func set_pawn(target: Pawn):
	if pawn == target: return
	if pawn:
		pawn._uncontrolled(self)
		pawn.get_node("%head").get_node("camera_target").queue_free()
		set_process(false)
		set_process_unhandled_input(false)
	
	pawn = target
	pawn._controlled(self)
	set_process(true)
	set_process_unhandled_input(true)
	
	pawn_camera.set_target(pawn)
	camera_master.target = pawn_camera.camera
	# Copy camera rotation to head.
	var pawn_head: Node3D = pawn.get_node("%head")
	pawn_camera.get_node("%head_remote").remote_path = pawn_head.get_path()
	
	# Copy head position to camera.
	var remote := RemoteTransform3D.new()
	remote.name = "camera_target"
	remote.update_position = true
	remote.update_rotation = false
	remote.update_scale = false
	pawn_head.add_child(remote)
	remote.remote_path = pawn_camera.get_path()
	
