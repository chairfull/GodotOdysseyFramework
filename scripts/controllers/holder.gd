class_name Holder extends Node3D

signal held()
signal unheld()

@export var controllable: Controllable:
	set(c):
		if c == controllable: return
		if controllable: unheld.emit()
		controllable = c
		if controllable: held.emit()

func is_holding() -> bool:
	return controllable != null
