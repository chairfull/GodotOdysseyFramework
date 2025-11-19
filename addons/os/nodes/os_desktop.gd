class_name OSDesktop extends Node

@export var os: OperatingSystem
@export var files_container: Control
@export var files_draggable := true
var _file_dragged: OSFileIcon

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if files_container:
		files_container.child_entered_tree.connect(_file_added)
		files_container.child_exiting_tree.connect(_file_removed)
		for file in files_container.get_children():
			_file_added(file)
	else:
		push_warning("[OS Desktop] No file container.")

func _file_added(node: Node) -> void:
	if node is OSFileIcon:
		node.gui_input.connect(_file_input_event.bind(node))

func _file_removed(node: Node) -> void:
	if node is OSFileIcon:
		node.gui_input.disconnect(_file_input_event)

func _file_input_event(ev: InputEvent, file: OSFileIcon) -> void:
	if ev is InputEventMouseButton:
		if ev.is_pressed():
			_file_dragged = file
			get_viewport().set_input_as_handled()
		elif ev.is_released():
			_file_dragged = null
			get_viewport().set_input_as_handled()
	elif ev is InputEventMouseMotion:
		if _file_dragged:
			var pos: Vector2 = _file_dragged.global_position + ev.relative
			var rect := files_container.get_global_rect()
			rect.size -= _file_dragged.size
			_file_dragged.global_position = Vector2(
				clampf(pos.x, rect.position.x, rect.size.x),
				clampf(pos.y, rect.position.y, rect.size.y)
			)
			get_viewport().set_input_as_handled()
