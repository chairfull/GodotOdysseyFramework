class_name QuestInfo extends DatabaseObject

enum QuestState {
	UNSTARTED,		## Not started.
	DISCOVERED,		## Known about.
	STARTED,		## Started.
	PASSED,			## Finished success.
	FAILED,			## Finished failed.
}

static func get_state_color(s := QuestState.UNSTARTED) -> Color:
	match s:
		QuestState.UNSTARTED: return Color(1., 1., 1., 0.5)
		QuestState.DISCOVERED: return Color.WHITE
		QuestState.STARTED: return Color.DEEP_SKY_BLUE
		QuestState.PASSED: return Color.GREEN_YELLOW
		QuestState.FAILED: return Color.TOMATO
	return Color.PURPLE

@export var desc: String
@export var types: Array[StringName]
@export var ticks: Dictionary[StringName, QuestTick]
@export var state := QuestState.UNSTARTED: set=set_state
@export var stats := StatDB.new()
@export var triggers: Dictionary[QuestState, Array]
@export var visible := true ## Sometimes invisible quests are wanted. They shouldn't create toasts.
@export var marked_for_notification := false

func has_notification() -> bool:
	for tick in ticks.values():
		if tick.marked_for_notification:
			return true
	return marked_for_notification

func mark_notification() -> void:
	marked_for_notification = true

func clear_notification() -> void:
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

func _get_devmode() -> Array:
	var options := []
	for s in QuestState.keys():
		options.append({text=QuestState.keys()[s]})
		if state != s:
			options[-1].call = set_state.bind(s)
	return options

func is_unstarted() -> bool: return state == QuestState.UNSTARTED
func is_discovered() -> bool: return state == QuestState.DISCOVERED
func is_started() -> bool: return state == QuestState.STARTED
func is_passed() -> bool: return state == QuestState.PASSED
func is_failed() -> bool: return state == QuestState.FAILED
func is_completed() -> bool: return is_passed() or is_failed()
func is_active() -> bool: return not is_unstarted() and not is_completed()

func start() -> void:
	if state == QuestState.UNSTARTED:
		state = QuestState.STARTED
		World.QUEST_STARTED.fire({ quest=self })

func set_passed() -> void:
	if state != QuestState.PASSED:
		state = QuestState.PASSED
		World.QUEST_PASSED.fire({ quest=self })
		
func set_failed() -> void:
	if state != QuestState.FAILED:
		state = QuestState.FAILED
		World.QUEST_FAILED.fire({ quest=self })

func ticked(...tick_ids) -> bool:
	for tid in tick_ids:
		if not tid in ticks:
			push_error("No tick %s in quest %s." % [tid, id])
			return false
		if not ticks[tid].completed: return false
	return true

func _get(property: StringName) -> Variant:
	for tick_id in ticks:
		if tick_id == property:
			return ticks[tick_id]
	if stats.has(property):
		return stats.get(property)
	return null

func _set(property: StringName, value: Variant) -> bool:
	for tick_id in ticks:
		if tick_id == property:
			push_error("Can't set tick as property.", self, property)
			return true
	if stats.has(property):
		stats.set(property, value)
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
	return World.quests
