@tool
class_name CinematicGenerator extends Node

@export_file(".json") var file := "res://assets/dummy.json"
@export_tool_button("Regen") var _toolbutton_regen := _regenerate
@export var default_delay := 0.5
@export var anim: AnimationPlayer
var _player: AnimationPlayer
var _library: AnimationLibrary ## Current lib being generated.
var _branch_anim: Animation ## Current anim being generated.
var _branch_state: Dictionary ## State of current anim branch.
var _branch_time: float ## Total time of current anim branch.
var _screens: Node

const HUD_CAPTION = preload("uid://dsa17lrw23t4")
const HUD_MENU = preload("uid://cucq8gseatpvc")

func get_state(key: StringName, default: Variant = null) -> Variant:
	return _branch_state.get(key, default)

func has_state(key: StringName) -> bool:
	return key in _branch_state

func set_state(key: StringName, value: Variant) -> void:
	_branch_state[key] = value

func _ready() -> void:
	if not Engine.is_editor_hint():
		_regenerate()

func _regenerate():
	var gen_time := Time.get_ticks_msec()
	
	if anim:
		remove_child(anim)
		anim.queue_free()
		anim = null
	
	_player = Cinematic.new()
	_player.set_root(^".")
	
	_screens = CanvasLayer.new()
	_player.add_child(_screens)
	_screens.name = "screens"
	_screens.owner = _player
	
	add_file(file)
	add_file("res://assets/other.json")
	
	var path := "res://assets/cinematics/%s.tscn" % ["dummy"]
	var packed := PackedScene.new()
	var err := packed.pack(_player)
	if err != OK:
		push_error("Couldn't pack.")
		return
	
	err = ResourceSaver.save(packed, path)
	if err != OK:
		push_error("Couldn't save.")
		return
	
	anim = load(path).instantiate()
	add_child(anim)
	anim.owner = self
	
	prints("Generated in %s ms." % [Time.get_ticks_msec() - gen_time])

func add_file(path: String) -> void:
	_library = AnimationLibrary.new()
	var lib_id := path.get_basename().get_file()
	if _player.has_animation_library(lib_id):
		return
	_player.add_animation_library(lib_id, _library)
	var json := FileAccess.get_file_as_string(path)
	var json_data: Variant = JSON.parse_string(json)
	for branch in json_data.branches:
		var steps: Array[Dictionary]
		steps.assign(json_data.branches[branch].steps)
		add_branch(branch, steps)

func add_branch(branch_id: StringName, steps: Array[Dictionary]):
	_branch_anim = Animation.new()
	_branch_anim.length = 0.0
	_branch_state = {}
	_branch_time = 0.0
	
	var track := _branch_anim.add_track(Animation.TYPE_METHOD)
	_branch_state.t_methods = track
	_branch_anim.track_set_path(track, ^".")
	
	for step in steps:
		match step.type:
			&"cap":
				var state := add_object("caption", HUD_CAPTION)
				state.node._cinematic_step(self, step)
			&"menu":
				var state := add_object("menu", HUD_MENU)
				state.node._cinematic_step(self, step)
			&"wait":
				add_time(1.0)
			&"cond":
				add_method(&"cond", step.cond)
				add_time(1.0)
			_:
				print("Unimplemented: ", step)
	_library.add_animation(branch_id, _branch_anim)

func has_object(id: String) -> bool:
	return get_object(id) != null

func get_object(id: String) -> Node:
	return _player.get_node_or_null(id)

func add_object(id: String, packed: PackedScene) -> Dictionary:
	if not has_object(id):
		var node := packed.instantiate()
		_player.add_child(node)
		node.name = id
		node.owner = _player
	if not has_state(id):
		var node := get_object(id)
		set_state(id, { node=node, node_path=".".path_join(id) })
	return get_state(id)

func add_checkpoint():
	add_method(&"wait")
	#_branch_anim.track_insert_key(_branch_state.t_methods, _branch_time, { method=&"wait", args=[] })

func add_method(method: StringName, args: Array = []):
	_branch_anim.track_insert_key(_branch_state.t_methods, _branch_time, { method=method, args=args })

func add_track(node: Node, property: NodePath, update: Variant = null, interp: Variant = null) -> int:
	var state_name := node.name
	var state: Dictionary = get_state(state_name, {})
	var path := "%s:%s" % [state.node_path, property]
	if update == null:
		var node_res := _player.get_node_and_resource(path)
		var obj: Object = (node_res[1] if node_res[1] else node_res[0])
		var prop: Variant = obj.get_indexed(node_res[2])
		match typeof(prop):
			TYPE_FLOAT, TYPE_INT, TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4: update = Animation.UPDATE_CONTINUOUS
			_: update = Animation.UPDATE_DISCRETE
	if interp == null:
		var node_res := _player.get_node_and_resource(path)
		var obj: Object = (node_res[1] if node_res[1] else node_res[0])
		var prop: Variant = obj.get_indexed(node_res[2])
		match typeof(prop):
			TYPE_FLOAT, TYPE_INT, TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4: interp = Animation.INTERPOLATION_LINEAR
			_: interp = Animation.INTERPOLATION_NEAREST
	var track_name := "t_%s" % property
	if not track_name in state:
		var track := _branch_anim.add_track(Animation.TYPE_VALUE)
		_branch_anim.track_set_path(track, path)
		_branch_anim.track_set_interpolation_type(track, interp)
		_branch_anim.value_track_set_update_mode(track, update)
		state[track_name] = track
	return state[track_name]

func add_key(track: int, time: float, key: Variant, transition: float = 1.0):
	_branch_anim.track_insert_key(track, time, key, transition)

func add_time(amount: float = default_delay):
	_branch_time += amount
	_branch_anim.length += amount

func get_time() -> float:
	return _branch_time
