class_name CameraTarget extends Node3D

@export var camera: Camera3D

func _ready() -> void:
	if camera:
		camera.current = false

func make_current():
	CameraMaster.ref.target = camera
