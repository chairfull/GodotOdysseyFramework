class_name Mount extends Node3D

signal mounted()
signal unmounted()

@export var controllable: Controllable:
	set(c):
		if c == controllable: return
		if controllable: unmounted.emit()
		controllable = c
		if controllable: mounted.emit()

func is_mounted() -> bool:
	return controllable != null
