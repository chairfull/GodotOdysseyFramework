class_name QuestDB extends Database

func connect_signals() -> void:
	State.event.connect(_event)

func _event(e: Event):
	for quest: QuestInfo in _objects.values():
		if quest.state in quest.triggers:
			for trigger: TriggerInfo in quest.triggers[quest.state]:
				if trigger.check(e):
					Cinema.queue(trigger.cinematic)
	match e:
		State.QUEST_STARTED: Audio.play(&"quest_log_updated")
		State.QUEST_TICKED: Audio.play(&"quest_log_updated")

func get_object_script() -> GDScript:
	return QuestInfo
