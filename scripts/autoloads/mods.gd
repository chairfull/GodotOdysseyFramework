extends Node

var enabled: Array[StringName]

func enable(id: StringName):
	if not id in enabled: enabled.append(id)

func disable(id: StringName):
	if id in enabled: enabled.erase(id)

func get_enabled() -> Array[ModInfo]:
	return [load("res://assets/mods/main.tres")]
