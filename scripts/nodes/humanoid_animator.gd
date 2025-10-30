extends AnimationTree

@export var humanoid: Humanoid: set=set_humanoid

var walk_blend := 0.0

func set_humanoid(h: Humanoid):
	humanoid = h
	if not humanoid: return
	humanoid.jumped.connect(func(): travel(&"Jump"))
	humanoid.landed.connect(func(_m: float = 0.0): travel(&"Standing"))
	humanoid.prone_state_changed.connect(func():
		match humanoid.prone_state:
			Humanoid.ProneState.Stand: travel(&"Standing")
			Humanoid.ProneState.Crouch: travel(&"Crouching")
			Humanoid.ProneState.Crawl: travel(&"Crawling")
		)
		
func travel(to: StringName):
	print("TRAVEL ", to)
	var sm: AnimationNodeStateMachinePlayback = get(&"parameters/main/playback")
	sm.travel(to)

func _process(delta: float) -> void:
	if not humanoid: return
	walk_blend = lerpf(walk_blend, humanoid.movement.length(), 15.0 * delta)
	set(&"parameters/main/Standing/blend_position", walk_blend)
	set(&"parameters/main/Crouching/blend_position", walk_blend)
	set(&"parameters/main/Crawling/blend_position", walk_blend)
