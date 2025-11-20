class_name AwardDB extends Database

func connect_signals() -> void:
	World.event.connect(_event)
	
	for ach: AwardInfo in objects():
		for event_id in ach.events:
			var ev: Event = World[event_id]
			ev.connect_to(ach._ev)

func _event(event: Event):
	match event:
		pass

func get_field_script() -> GDScript:
	return AwardInfo
