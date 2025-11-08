class_name QuestInfo extends DatabaseObject

enum QuestState {
	HIDDEN,			## Not started.
	ACTIVE,			## Started.
	PASSED,			## Finished success.
	FAILED,			## Finished failed.
}

static func get_state_color(s := QuestState.HIDDEN) -> Color:
	match s:
		QuestState.HIDDEN: return Color(1., 1., 1., 0.5)
		QuestState.ACTIVE: return Color.WHITE
		QuestState.PASSED: return Color.GREEN_YELLOW
		QuestState.FAILED: return Color.TOMATO
	return Color.PURPLE

#@export var fmods: Array[QuestFMod]
@export var ticks: Dictionary[StringName, QuestTick]
@export var state := QuestState.HIDDEN: set=set_state
@export var vars := VarDB.new()
@export var hidden := false
@export var triggers: Dictionary[QuestState, Array]
@export var marked_for_notification := false
var desc: String

func has_notification() -> bool:
	for tick in ticks.values():
		if tick.marked_for_notification:
			return true
	return marked_for_notification
func mark_notification(): marked_for_notification = true
func clear_notification():
	for tick in ticks.values():
		tick.marked_for_notification = false
	marked_for_notification = false

func find_tick(tid: String) -> QuestTick:
	for tick_id in ticks:
		if tick_id == tid:
			return ticks[tick_id]
	return null

func set_state(s: QuestState):
	if state == s: return
	state = s
	changed.emit()

#func _get_devmode() -> Array:
	#var options := []
	#for s in [Style.HIDDEN, Style.ACTIVE, Style.PASSED, Style.FAILED]:
		#options.append({text=Style.keys()[s]})
		#if style != s:
			#options[-1].call = set_style.bind(s)
	#return options

func _get(property: StringName) -> Variant:
	for tick_id in ticks:
		if tick_id == property:
			return ticks[tick_id]
	if vars.has(property):
		return vars.get(property)
	return null

func _set(property: StringName, value: Variant) -> bool:
	for tick_id in ticks:
		if tick_id == property:
			push_error("Can't set tick as property.", self, property)
			return true
	if vars.has(property):
		vars.set(property, value)
		return true
	return false

func _iter_init(iter) -> bool:
	iter[0] = 0
	return iter[0] < ticks.size()

func _iter_next(iter) -> bool:
	iter[0] += 1
	return iter[0] < ticks.size()

func _iter_get(iter) -> Variant:
	return ticks[iter]

func get_db() -> Database:
	return State.quests
