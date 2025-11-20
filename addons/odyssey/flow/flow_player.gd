#@icon("res://addons/odyssey/flow")
class_name FlowPlayer extends AnimationPlayer

signal wait_started()
signal wait_ended()
signal ended()

## Multiple methods may be called in a single tick this way.
@export var method_calls: Dictionary[int, Array]
var _waiting_for_user := false
var _stack: Array[Array]

func _ready() -> void:
	if not Engine.is_editor_hint():
		animation_finished.connect(_animation_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"advance_cinematic") and _waiting_for_user:
		get_viewport().set_input_as_handled()
		_waiting_for_user = false
		wait_ended.emit()
		seek(current_animation_position + .01)
		play()

func _meth(hash_index: int):
	if hash_index in method_calls:
		for item in method_calls[hash_index]:
			var meth_id: StringName = item[0]
			var meth_args: Array = item[1]
			Log.msg("FlowPlayer", "Method", item)
			match meth_id:
				&"_expr": World.call("_expr_%s" % meth_args[0])
				&"_cond":
					var conds: Array = meth_args[0]
					for cond in conds:
						var cond_hash: int = cond[0]
						var cond_branch: StringName = cond[1]
						if World.call("_cond_%s" % cond_hash):
							goto(cond_branch)
							break
				&"_event":
					var ev_id: StringName = meth_args[0]
					var ev_data: String = meth_args[1]
					Cinema._event(ev_id, ev_data)
				&"_break":
					if is_playing():
						var curr := current_animation
						stop(true)
						_animation_finished(curr)
				_: callv(meth_id, meth_args)

func _animation_finished(anim_id: StringName):
	Log.msg("FlowPlayer", "Animation Finished", [anim_id])
	if _stack:
		var last: Array = _stack.pop_back()
		var anim: StringName = last[0]
		var position: float = last[1]
		Log.msg("FlowPlayer", "Continue from", [], { anim=anim, position=position })
		_play(anim, position)
	else:
		Log.msg("FlowPlayer", "Finished")
		end()

func end():
	Log.msg("FlowPlayer", "Stopped")
	stop(true)
	ended.emit()

## Wait for user to press something.
func wait():
	if not is_playing(): return
	if _waiting_for_user: return
	_waiting_for_user = true
	wait_started.emit()
	pause()
	print("Waiting for user input.")

func goto(id: StringName, return_after := true, clear_stack := false):
	Log.msg("FlowPlayer", "Goto", [id], {return_after=return_after, clear_stack=clear_stack})
	if clear_stack:
		_stack.clear()
	
	if return_after:
		# Add a tenth of a second offset, so we don't repeat/loop.
		_stack.append([current_animation, current_animation_position + .01])
	
	if "/" in id:
		_play(id)
	else:
		var branch := current_animation.split("/", true, 1)[0]
		_play(branch + "/" + id)

func _play(id: StringName, at := 0.0):
	Log.msg("FlowPlayer", "Play", [], { anim=id, at=at })
	assigned_animation = id
	seek(at, false)
	play()
