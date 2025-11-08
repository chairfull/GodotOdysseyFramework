class_name AchievementInfo extends DatabaseObject

@export var desc: String
@export var tick := 0
@export var max_ticks := 1
@export var unlocked: bool:
	get: return tick >= max_ticks
	set(t): tick = max_ticks if t else 0

@export var events: Dictionary[StringName, StringName]

func connect_signals():
	for event_id in events:
		var event: Event = State[event_id]
		event.connect_to(_event)

func _event(e: Event):
	match e:
		pass

func set_unlocked(u: bool):
	if unlocked == u: return
	unlocked = u
	
	State.ACHIEVEMENT.emit()
	for event_id in events:
		State[event_id].disconnect(_event)
