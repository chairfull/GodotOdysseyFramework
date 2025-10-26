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

static func get_move_vector() -> Vector2:
	return Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")



func hud_is_visible(id: StringName) -> bool:
	return id in _hud

func hud_show(id: StringName) -> Node:
	return null

func hud_hide(id: StringName):
	pass

func _unhandled_input(event: InputEvent) -> void:
	if index != 0: return
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
