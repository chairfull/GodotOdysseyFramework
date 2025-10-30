extends HumanoidState

var camera: CameraTarget

func _enter_tree() -> void:
	camera = Assets.create_prefab(&"camera_third_person", humanoid)

func _exit_tree() -> void:
	humanoid.remove_child(camera)
	camera.queue_free()
