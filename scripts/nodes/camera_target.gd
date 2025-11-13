class_name CameraTarget extends Node3D

@export var camera: Camera3D
@export var target: Node3D: set=set_target

func set_target(t: Node3D) -> void:
	target = t
