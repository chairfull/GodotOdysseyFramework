extends Node

var _enabled: Array[StringName]

func enable(id: StringName):
	if not id in _enabled: _enabled.append(id)

func disable(id: StringName):
	if id in _enabled: _enabled.erase(id)
