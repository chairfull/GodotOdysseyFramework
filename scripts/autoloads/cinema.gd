extends Node

signal started()
signal ended()

class QueuedCinematic extends Resource:
	var id: StringName
	var type: StringName
	var state: Dictionary[StringName, Variant]

var _queue: Array[QueuedCinematic]

func queue(id: StringName, state: Dictionary[StringName, Variant] = {}):
	var cin := QueuedCinematic.new()
	cin.id = id
	cin.state = state
	_queue.append(cin)

func exists(_id: StringName) -> bool:
	return true

func _start():
	started.emit()

func _end():
	ended.emit()
