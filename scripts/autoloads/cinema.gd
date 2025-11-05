extends Node

signal started()
signal ended()

var _queue: Array[Array]
var _current: Cinematic
var _state: Dictionary[StringName, Variant]

func queue(scene: Variant, state: Dictionary[StringName, Variant] = {}):
	if is_playing():
		_queue.append([scene, state])
	else:
		print("CINEMA STARTED")
		get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
		started.emit()
		_play(scene, state)

func _play(scene: Variant, state: Dictionary[StringName, Variant]):
	_state = state
	var id: String
	if scene is PackedScene:
		_current = scene.instantiate()
		id = scene.resource_path.get_basename().get_file()
	elif scene is Cinematic:
		_current = scene
		id = scene.name
	elif scene is CinemaScript:
		_current = CinematicGenerator.gen([scene])
		id = scene.get_id()
	add_child(_current)
	_current.ended.connect(_cinematic_ended)
	_current.play(id + "/ROOT")

func _cinematic_ended():
	ended.emit()
	remove_child(_current)
	_current.queue_free()
	_current = null
	if _queue:
		var next: Array = _queue.pop_front()
		_play(next[0], next[1])
	else:
		get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
		ended.emit()
		print("CINEMA ENDED")

func is_playing() -> bool:
	return _current != null

func exists(_id: StringName) -> bool:
	return true
