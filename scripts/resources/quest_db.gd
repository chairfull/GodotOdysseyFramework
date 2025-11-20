class_name QuestDB extends Database

const EVENT_START := &"QUEST_START"
const EVENT_PASS := &"QUEST_PASS"
const EVENT_FAIL := &"QUEST_FAIL"
const EVENT_TICK := &"QUEST_TICK"
const EVENT_SHOW := &"QUEST_SHOW"
const EVENT_HIDE := &"QUEST_HIDE"
const ALL_EVENTS := [EVENT_START, EVENT_PASS, EVENT_FAIL, EVENT_TICK, EVENT_SHOW, EVENT_HIDE]

func connect_signals() -> void:
	World.event.connect(_state_event)
	Cinema.event.connect(_cinema_event)

func _cinema_event(id: StringName, data: String) -> void:
	if not id in ALL_EVENTS: return
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
	
	match id:
		EVENT_START: quest.start()
		EVENT_PASS: quest.set_passed()
		EVENT_FAIL: quest.set_failed()
		EVENT_TICK: tick.tick += 1
		EVENT_SHOW: tick.show()
		EVENT_HIDE: push_warning("Quest hiding not implemented. Just don't call show().")

func _check_triggers(obj: Object, event: Event):
	var state: QuestInfo.QuestState = obj.state
	var triggers: Dictionary[QuestInfo.QuestState, Array] = obj.triggers
	if not state in triggers: return
	for trigger: TriggerInfo in triggers[state]:
		if trigger.check(event):
			Cinema.queue(trigger.flow_script)

func _state_event(e: Event):
	for quest: QuestInfo in _objects.values():
		# Check for state event triggers.
		_check_triggers(quest, e)
		# Check for tick event triggers.
		for tick_id in quest.ticks:
			var tick := quest.ticks[tick_id]
			_check_triggers(tick, e)
		
	match e:
		World.QUEST_STARTED:
			Audio.play(&"quest_log_updated")
			World.TOAST.fire({ data={text="Quest Started"} })
			
		World.QUEST_TICKED:
			Audio.play(&"quest_log_updated")
			World.TOAST.fire({ data={text="Quest Updated"} })

func get_object_script() -> GDScript:
	return QuestInfo
