class_name Cinematic extends AnimationPlayer

signal wait_started()
signal wait_ended()
signal ended()

var _waiting_for_user := false
var _stack: Array[Array]

func _ready() -> void:
	if not Engine.is_editor_hint():
		animation_finished.connect(_animation_finished)
		#play(&"ROOT")

func _animation_finished(_a: StringName):
	if _stack:
		var last: Array = _stack.pop_back()
		var anim: StringName = last[0]
		var position: float = last[1]
		play(anim)
		seek(position)
	else:
		print("All finished.")
		end()

func end_branch():
	if is_playing():
		var curr := current_animation
		stop()
		_animation_finished(curr)

func end():
	stop()
	ended.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"advance_cinematic") and _waiting_for_user:
		get_viewport().set_input_as_handled()
		_waiting_for_user = false
		wait_ended.emit()
		seek(current_animation_position+.01)
		play()

## Wait for user to press something.
func wait():
	if not is_playing(): return
	if _waiting_for_user: return
	_waiting_for_user = true
	wait_started.emit()
	pause()
	print("Waiting for user input.")

func goto(id: StringName, return_after := true, clear_stack := false):
	if clear_stack:
		_stack.clear()
	
	if return_after:
		_stack.append([current_animation, current_animation_position])
	
	if "/" in id:
		play(id)
	else:
		var branch := current_animation.split("/", true, 1)[0]
		play(branch + "/" + id)

## Runs through a list of condition strings and plays first anim branch that evalutes true.
func cond(conds: Array) -> bool:
	for i in range(0, conds.size(), 2):
		var test: String = conds[i]
		var anim: String = conds[i+1]
		if State.test(test):
			goto(anim)
			return true
	return false

## Set current camera.
func camera():
	pass
