class_name AchievementDB extends Database

func connect_signals() -> void:
	State.event.connect(_event)
	
	for ach: AchievementInfo in objects():
		for event_id in ach.events:
			var ev: Event = State[event_id]
			ev.connect_to(ach._ev)

func _event(event: Event):
	match event:
		pass

func get_field_script() -> GDScript:
	return AchievementInfo
