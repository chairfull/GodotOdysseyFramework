@tool
class_name QuipNode extends AnimationPlayer
## Plays a random quip.
"""
# Example Script.
FILE audio/dlg/knight/quips.ogg
	How's it going? @2.0-2.82
	Nice day isn't it? @4.7-5.7

FILE audio/dlg/knight/quips2.ogg
	BLOCK
		Shield up. @0.0-1.0
		Worlds never friendly. @1.07-2.6
	A good horse is better company than most people. @2.9-5.39
	BLOCK
		The bards embelish everything. @5.9-7.7
		Except the smell of battle. @7.71-9.11
		That they understate. @9.3-10.5
"""


signal caption_changed(msg: String)
signal caption_visibility_changed(visible: bool)

@export var flow: FlowScript
@export_tool_button("Generate") var _tb_regen := reload_flow
@export var audio_arent: Node3D
@export_storage var _caption: int: set=set_caption
@export_storage var _caption_visible: bool: set=set_caption_visible
@export_storage var _captions: Array[String]
@export_storage var _unplayed: Array[StringName]
@export_storage var _last: StringName
@export_storage var _players: Array[AudioStreamPlayer3D]

func _ready() -> void:
	if not Engine.is_editor_hint():
		reload_flow.call_deferred()

## Picks a random quip, being sure not to play the same one twice.
func play_random() -> void:
	if is_playing():
		push_warning("Already playing.")
		return
	
	# Populate list with all available quips.
	if _unplayed.is_empty():
		var lib := get_animation_library(&"")
		_unplayed.assign(lib.get_animation_list())
	
	# Pick random.
	var next: StringName = _unplayed.pick_random()
	while next == _last and _unplayed.size() > 1:
		next = _unplayed.pick_random()
	
	_unplayed.erase(next)
	animation_finished.connect(func(id: StringName): print("Finished ", id), CONNECT_ONE_SHOT)
	play(next)
	_last = next

func reload_flow() -> void:
	var steps := flow.get_parsed()
	var mod_dir := "res://assets/mods/main"
	
	_captions.clear()
	
	if &"" in get_animation_list():
		remove_animation_library(&"")
	add_animation_library(&"", AnimationLibrary.new())
	
	for player in _players:
		audio_arent.remove_child(player)
		player.queue_free()
	
	for step in steps.tabbed:
		match step.type:
			FlowToken.CMND:
				match step[FlowToken.CMND]:
					&"FILE":
						var current_audio_file := mod_dir.path_join(step.rest)
						var current_audio_stream := load(current_audio_file)
						#var current_audio_player := AudioStreamPlayer3D.new()
						var current_audio_player := RaytracedAudioPlayer3D.new()
						audio_arent.add_child(current_audio_player)
						_players.append(current_audio_player)
						current_audio_player.unit_size = 2.0
						current_audio_player.name = current_audio_file.get_basename().get_file()
						current_audio_player.stream = current_audio_stream
						
						var current_audio_node_path := get_node(root_node).get_path_to(current_audio_player)
						
						for file_step in step.tabbed:
							match file_step.type:
								FlowToken.CMND:
									match file_step[FlowToken.CMND]:
										&"BLOCK":
											var texts: Array[String]
											for block_step in file_step.tabbed:
												match block_step.type:
													FlowToken.TEXT:
														texts.append(block_step.text)
											_add_quip(texts, current_audio_node_path, current_audio_stream)
								FlowToken.TEXT:
									_add_quip([file_step.text], current_audio_node_path, current_audio_stream)

func _add_quip(lines: Array[String], current_audio_node_path: NodePath, current_audio_stream: Resource) -> void:
	var anim := Animation.new()
	var t_audio := anim.add_track(Animation.TYPE_AUDIO)
	anim.track_set_path(t_audio, current_audio_node_path)
	var t_caption := anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(t_caption, ^".:_caption")
	anim.value_track_set_update_mode(t_caption, Animation.UPDATE_DISCRETE)
	var t_caption_visible := anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(t_caption_visible, ^".:_caption_visible")
	anim.value_track_set_update_mode(t_caption_visible, Animation.UPDATE_DISCRETE)
	var texts: Array[String]
	var offset := 0.0
	var buffer := 0.1 # TODO: Within buffer we should check if audio should be cancelled.
	var stream_length := (current_audio_stream as AudioStream).get_length()
	for line in lines:
		var parts := line.split("@", true, 1)
		var text := parts[0].strip_edges()
		var times := parts[-1].split("-", true, 1)
		var sound_start := times[0].to_float()
		var sound_end := times[1].to_float()
		var sound_length := sound_end - sound_start
		anim.audio_track_insert_key(t_audio, offset, current_audio_stream, sound_start, stream_length - sound_end)
		anim.track_insert_key(t_caption, offset, _captions.size())
		anim.track_insert_key(t_caption_visible, offset, true)
		anim.track_insert_key(t_caption_visible, offset + sound_length, false)
		offset += sound_length
		offset += buffer
		texts.append(text)
		_captions.append(text)
	anim.length = offset
	var lib := get_animation_library(&"")
	lib.add_animation(" ".join(texts), anim)
	
func set_caption(c: int) -> void:
	_caption = c
	caption_changed.emit(_captions[_caption])

func set_caption_visible(b: bool) -> void:
	_caption_visible = b
	caption_visibility_changed.emit(_caption_visible)
