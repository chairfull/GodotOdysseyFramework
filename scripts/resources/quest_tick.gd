class_name QuestTick extends Resource

@export var id: StringName
@export var quest_id: StringName
@export var state := QuestInfo.QuestState.HIDDEN: set=set_state
@export var tick := 0: set=set_tick
@export var max_ticks := 1
@export var name := ""
@export var desc := ""
@export var need: Array[StringName] ## Must all be true for any triggers to check.
@export var mark: Array[StringName] ## Highlights characts, zones, items...
@export var triggers: Array[TriggerInfo] ## Event that triggers this tick.
@export var visible: bool = false
@export var mark_for_notification := false

var quest: QuestInfo:
	get: return State.quests.find(quest_id)

var completed: bool:
	get: return tick == max_ticks
	set(t):
		if completed == t: return
		tick = max_ticks if t else 0
		mark_for_notification = true
		if completed:
			set_state(QuestInfo.QuestState.PASSED)

func set_state(s := QuestInfo.QuestState.HIDDEN):
	if state == s: return
	state = s
	mark_for_notification = true
	changed.emit()

func set_tick(t: int):
	if tick == t: return
	tick = t
	State.QUEST_TICKED.emit({ tick=self })
	if completed:
		State.QUEST_TICK_COMPLETED.emit({ tick=self })

func show() -> void:
	visible = true

func hide() -> void:
	visible = false

func _to_string() -> String:
	return "QuestTick(%s#%s)" % [quest_id, id]

#func _get_devmode() -> Array:
	#var options := []
	#var flow_id := quest.name + "#" + name
	#options.append({
		#text="Queue: %s" % name,
		#call=Flow.queue.bind(flow_id, { quest=quest, tick=tick }) })
	#if event:
		#options.append({
			#text="Trigger: %s" % [event],
			#call=event.fire.bind(event_state) })
	#if completed:
		#options.append(func set_complete(): completed = true)
	#if completed:
		#options.append(func set_uncomplete(): completed = false)
	#return options
