class_name QuestDB extends Database

func _init() -> void:
	State.event.connect(_event)

func _event(e: Event):
	match e:
		GameEvent.QUEST_STARTED: Audio.play(&"quest_log_updated")
		GameEvent.QUEST_TICKED: Audio.play(&"quest_log_updated")

func get_object_script() -> GDScript:
	return QuestInfo
