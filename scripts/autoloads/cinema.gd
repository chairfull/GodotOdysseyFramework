extends Node

signal event(id: StringName, data: Variant)
signal started()
signal ended()

var _queue: Array[Array]
var _current: FlowPlayer
var _state: Dictionary[StringName, Variant]

func _event(id: StringName, data: Variant):
	event.emit(id, data)

func queue(scene: Variant, state: Dictionary[StringName, Variant] = {}):
	if is_playing():
		_queue.append([scene, state])
	else:
		started.emit()
		State.add_pauser(self)
		_play(scene, state)

func _play(scene: Variant, state: Dictionary[StringName, Variant]):
	_state = state
	var id: String
	if scene is PackedScene:
		_current = scene.instantiate()
		id = scene.resource_path.get_basename().get_file()
	elif scene is FlowPlayer:
		_current = scene
		id = scene.name
	elif scene is FlowScript:
		_current = FlowPlayerGenerator.generate([scene])
		id = scene.get_id()
	add_child(_current)
	_current.ended.connect(_cinematic_ended)
	_current.play(id + "/ROOT")

func _cinematic_ended():
	Log.msg("Cinema Ended", _current, { queue=_queue })
	remove_child(_current)
	_current.queue_free()
	_current = null
	if _queue:
		var next: Array = _queue.pop_front()
		_play(next[0], next[1])
	else:
		State.remove_pauser(self)
		ended.emit()

func is_playing() -> bool:
	return _current != null

func exists(_id: StringName) -> bool:
	return true
