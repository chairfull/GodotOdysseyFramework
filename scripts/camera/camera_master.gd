class_name CameraMaster extends Camera3D

@export var target: Camera3D

static var ref: CameraMaster:
	get: return null if not Global.get_tree() else Global.get_tree().get_first_node_in_group(&"CameraMaster")

func _init() -> void:
	add_to_group(&"CameraMaster")

func _ready() -> void:
	make_current()

func _process(_delta: float) -> void:
	if not target: return
	global_transform = target.global_transform
	h_offset = target.h_offset
	v_offset = target.v_offset
	projection = target.projection
	fov = target.fov
	size = target.size
	near = target.near
	far = target.far
	
