class_name CameraTarget extends Node3D

@export var camera: Camera3D
@export var _make_current := false

func _ready() -> void:
	if not camera and convert(self, TYPE_OBJECT) is Camera3D:
		camera = convert(self, TYPE_OBJECT)
	
	if camera:
		camera.current = false
		if _make_current:
			make_current()

func make_current():
	CameraMaster.ref.target = camera
