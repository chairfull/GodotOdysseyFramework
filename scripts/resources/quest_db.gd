class_name QuestDB extends Database

const EVENT_START := &"QUEST_START"
const EVENT_PASS := &"QUEST_PASS"
const EVENT_FAIL := &"QUEST_FAIL"
const EVENT_TICK := &"QUEST_TICK"
const EVENT_SHOW := &"QUEST_SHOW"
const EVENT_HIDE := &"QUEST_HIDE"
const ALL_EVENTS := [EVENT_START, EVENT_PASS, EVENT_FAIL, EVENT_TICK, EVENT_SHOW, EVENT_HIDE]

func connect_signals() -> void:
	print("QUEST CONNECTED SIGNALS")
	State.event.connect(_state_event)
	Cinema.event.connect(_cinema_event)

func _cinema_event(id: StringName, data: String) -> void:
	var quest_id: StringName = data
	var tick_id: StringName = &""
	if "#" in data:
		var parts := data.split("#", true, 1)
		quest_id = parts[0]
		tick_id = parts[1]
	var quest: QuestInfo = find(quest_id)
	if not quest:
		push_error("No quest ", data)
		return
	var tick: QuestTick
	if tick_id:
		tick = quest.find_tick(tick_id)
		if not tick:
			push_error("No quest tick ", data)
			return
	
	prints("CINEMA", id, data, quest, tick)
	match id:
		EVENT_START: quest.start()
		EVENT_PASS: quest.set_passed()
		EVENT_FAIL: quest.set_failed()
		EVENT_TICK: tick.tick += 1
		EVENT_SHOW: tick.show()
		EVENT_HIDE: tick.hide()

func _state_event(e: Event):
	for quest: QuestInfo in _objects.values():
		if quest.state in quest.triggers:
			for trigger: TriggerInfo in quest.triggers[quest.state]:
				if trigger.check(e):
					Cinema.queue(trigger.flow_script)
	match e:
		State.QUEST_STARTED:
			Audio.play(&"quest_log_updated")
			State.TOAST.emit({ data={text="Quest Started"} })
			
		State.QUEST_TICKED:
			Audio.play(&"quest_log_updated")
			State.TOAST.emit({ data={text="Quest Updated"} })

func get_object_script() -> GDScript:
	return QuestInfo
