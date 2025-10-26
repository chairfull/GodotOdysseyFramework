extends AnimationTree

@export var humanoid: Humanoid: set=set_humanoid

var walk_blend := 0.0

func set_humanoid(h: Humanoid):
	humanoid = h
	if not humanoid: return
	humanoid.jumped.connect(func():
		var sm: AnimationNodeStateMachinePlayback = get(&"parameters/main/playback")
		sm.travel("Jump")
		)
	humanoid.landed.connect(func(_m: float = 0.0):
		var sm: AnimationNodeStateMachinePlayback = get(&"parameters/main/playback")
		sm.travel("Walk")
		)

func _process(delta: float) -> void:
	if not humanoid: return
	walk_blend = lerpf(walk_blend, humanoid.movement.length(), 15.0 * delta)
	set(&"parameters/main/Walk/blend_position", walk_blend)
