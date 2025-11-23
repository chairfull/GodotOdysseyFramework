class_name CameraTarget extends Node3D

@export var camera: Camera3D
@export var target: Node3D: set=set_target

@export var make_current := false

func _ready() -> void:
	if make_current:
		Controllers.player.camera_master.set_target(self)

func set_target(t: Node3D) -> void:
	target = t
