class_name CameraTopDown extends CameraTarget
# TODO: Move to main camera script

@onready var cursor: MeshInstance3D = %cursor

func _enter_tree() -> void:
	make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#func _process(delta: float) -> void:
	#var move := _c.get_move_vector()
	#var speed := 10.0
	#global_position += Vector3(move.x, 0.0, move.y) * speed * delta
