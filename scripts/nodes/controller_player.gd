class_name ControllerPlayer extends Controller

signal view_state_changed()

enum ViewState { None, FirstPerson, ThirdPerson, TopDown }

@onready var viewport_container: ControllerPlayer = %viewport_container
@onready var viewport: SubViewport = %viewport
@onready var camera_master: CameraMaster = %camera_master
var _hud: Dictionary[StringName, Node]

var view_state := ViewState.FirstPerson:
	set(vs):
		view_state = vs
		view_state_changed.emit()
		prints(name, view_state_changed.get_connections(), pawn)

func get_move_vector() -> Vector2:
	return Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")

func get_move_vector_camera() -> Vector2:
	var dir := camera_master.global_rotation.y
	return get_move_vector().rotated(-dir)

func is_hud_visible(id: StringName) -> bool:
	return id in _hud

func show_hud(id: StringName, props := {}) -> Node:
	var hud_id := "hud_" + id
	var hud: Node = _hud.get(hud_id)
	if not hud:
		hud = Assets.create_prefab(hud_id, self, props)
		_hud[hud_id] = hud
	return hud

func hide_hud(id: StringName) -> bool:
	var hud_id := "hud_" + id
	var hud: Node = _hud.get(hud_id)
	if hud:
		remove_child(hud)
		hud.queue_free()
		_hud.erase(hud_id)
		return true
	return false

func _unhandled_input(event: InputEvent) -> void:
	if name != "player_1": return
	if event.is_action_pressed(&"toggle_first_person", false, true):
		print("first person")
		view_state = ViewState.FirstPerson
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"toggle_third_person", false, true):
		print("third person")
		view_state = ViewState.ThirdPerson
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"toggle_top_down", false, true):
		print("top down")
		view_state = ViewState.TopDown
		get_viewport().set_input_as_handled()
