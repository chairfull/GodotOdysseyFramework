class_name QuestTick extends Resource

@export var state := QuestInfo.QuestState.HIDDEN: set=set_state
@export var tick := 0
var max_ticks := 1
var id: StringName
var name := ""
var desc := ""
var quest: QuestInfo
var need: Array[StringName] ## Must all be true for any triggers to check.
var mark: Array[StringName] ## Highlights characts, zones, items...
var event: Event ## Event that triggers this tick.
#var event_state: Dictionary[StringName, Variant]
var cond: String ## Condition that has to be met.

var completed: bool:
	get: return tick == max_ticks
	set(t):
		if completed != t:
			tick = max_ticks if t else 0
			if completed:
				set_state(QuestInfo.QuestState.PASSED)

func set_state(s := QuestInfo.QuestState.HIDDEN):
	if state == s: return
	state = s
	changed.emit()

func _to_string() -> String:
	return "QuestTick(%s#%s)" % [quest.name, name]

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
