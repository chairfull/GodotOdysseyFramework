class_name QuestInfo extends DatabaseObject

enum Style {
	HIDDEN,			## Not started.
	ACTIVE,			## Started.
	PASSED,			## Finished success.
	FAILED,			## Finished failed.
}

static func get_style_color(s := Style.HIDDEN) -> Color:
	match s:
		Style.HIDDEN: return Color(1., 1., 1., 0.5)
		Style.ACTIVE: return Color.WHITE
		Style.PASSED: return Color.GREEN_YELLOW
		Style.FAILED: return Color.TOMATO
	return Color.PURPLE

#@export var fmods: Array[QuestFMod]
@export var ticks: Array[QuestTick]
@export var style := Style.HIDDEN: set=set_style
@export var properties := PropertyDB.new()
@export var hidden := false
var desc: String

#func find_tick(tid: String) -> QuestTick:
	#for tick in ticks:
		#if tick.id == tid:
			#return tick
	#return null

func set_style(s: Style):
	if style == s:
		return
	style = s
	changed.emit()

func _get_devmode() -> Array:
	var options := []
	for s in [Style.HIDDEN, Style.ACTIVE, Style.PASSED, Style.FAILED]:
		options.append({text=Style.keys()[s]})
		if style != s:
			options[-1].call = set_style.bind(s)
	return options

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
