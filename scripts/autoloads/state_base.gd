@abstract class_name StateBase extends Node
## Handles state of world in a way where non-loaded content can be set/get.

signal paused()
signal unpaused()
@warning_ignore("unused_signal") signal event(event: Event)

const PATH_AUTOGEN_STATE := "res://_autogen_/_state_.gd"

#╒─══════──═─══☰☰☰☰☰☰☰═☰[░░░░]☰☰☰☰☰☰☰☰☰══─═──════─══╕
const LOGO := r"""
 ╭─╮┌─╮╮ ╷╭─╮╭─╮╭─╴╮ ╷  ┌─╴┌─╮╭─╮╭┬╮╭─╴╮╷╷╭─╮┌─╮╷ ╷ 
 │ │≈ │╰┼╯╰─╮╰─╮├─ ╰┼╯  ├─ ├┬╯├─┤│││├─ ││││ │├┬╯├┬╯
 ╰─╯└─╯ ╵ ╰─╯╰─╯╰─╴ ╵   ╵  ╵╰╴╯ ╵╵╵╵╰─╴╰┴╯╰─╯╵╰╴╯╰  
╘══════──═─═══════☰═☰(◟ v{version} ◝)☰═☰═════─═─═════════╛
"""

class PawnEvent extends Event:
	var pawn: Pawn
	var posessed: Pawn
	var controller: Controller

class QuestEvent extends Event:
	var quest: QuestInfo

class CharEvent extends Event:
	var who: CharInfo

class ZoneEvent extends Event:
	var zone: ZoneInfo
	var who: CharInfo

class QuestTickEvent extends QuestEvent:
	var tick: QuestTick

class ToastEvent extends Event:
	var type: StringName
	var player: int
	var icon: String
	var title: String
	var subtitle: String
	var data: Dictionary[StringName, Variant]

class StatEvent extends Event:
	var stat: StatInfo
	var old: Variant
	var new: Variant
	func is_decreased() -> bool: return new < old
	func is_increased() -> bool: return new > old
	func is_reset() -> bool: return new == stat.default

class AwardEvent extends Event:
	var award: AwardInfo

#region Events.
var PAWN_ENTERED := PawnEvent.new()
var PAWN_EXITED := PawnEvent.new()

var ZONE_ENTERED := ZoneEvent.new()
var ZONE_EXITED := ZoneEvent.new()

var STAT_CHANGED := StatEvent.new()

var QUEST_STARTED := QuestEvent.new()
var QUEST_TICKED := QuestTickEvent.new()
var QUEST_TICK_COMPLETED := QuestTickEvent.new()
var QUEST_TICK_PASSED := QuestTickEvent.new()
var QUEST_TICK_FAILED := QuestTickEvent.new()
var QUEST_PASSED := QuestEvent.new()
var QUEST_FAILED := QuestEvent.new()

var AWARD_UNLOCKED := AwardEvent.new()
var AWARD_PROGRESSED := AwardEvent.new()

var TOAST := ToastEvent.new()
#endregion

signal period_finished(id: StringName)
signal period_started(id: StringName)
signal season_started(id: StringName)
signal season_finished(id: StringName)

@export var play_time: DateTime
@export var objects: StateObjects
@export var time: DateTimeline
@export var milliseconds_per_second := DateTime.MS_IN_SECOND
var dbs: Array[Database]
var _loaded := false
var _pausers: Array[Object]
var _delta: float
var _last_period: StringName
var _last_season: StringName

func _true_reload():
	objects = StateObjects.new()
	dbs = objects.get_dbs()
	play_time = DateTime.new()
	
	time = DateTimeline.new()
	time.add_periods(DateTimeline.DEFAULT_PERIODS, _period)
	time.add_seasons(DateTimeline.DEFAULT_SEASONS, _season)
	
	var mods := Mods.get_enabled()
	for mod in mods:
		var mod_dbs := mod.get_dbs()
		for i in dbs.size():
			dbs[i].merge(mod_dbs[i])
	
	for db in dbs:
		db.connect_signals()
	
	# Pass Events their variable name.
	for prop in get_property_list():
		if UBit.is_enabled(prop.usage, PROPERTY_USAGE_SCRIPT_VARIABLE):
			if prop.type == TYPE_OBJECT and self[prop.name] is Event:
				self[prop.name].id = prop.name
	
	_loaded = true
	Global.msg("State", "Reloaded", [objects.get_counts_string()])

func _period(id: StringName) -> void:
	Global.msg("Time", "Period: " + id)
	period_finished.emit(_last_period)
	period_started.emit(id)
	_last_period = id

func _season(id: StringName) -> void:
	Global.msg("Time", "Season: " + id)
	season_finished.emit(_last_season)
	season_started.emit(id)
	_last_season = id

func _process(delta: float) -> void:
	_delta += delta
	if _delta >= 1.0:
		_delta -= 1.0
		time.advance(milliseconds_per_second)
		
var chars: CharDB:
	get: return objects.chars
var items: ItemDB:
	get: return objects.items
var zones: ZoneDB:
	get: return objects.zones
var stats: StatDB:
	get: return objects.stats
var quests: QuestDB:
	get: return objects.quests

func _init() -> void:
	# reload() calls set_script() which triggers this _init().
	# We know we are in business once we are the generated script.
	if get_script().resource_path == PATH_AUTOGEN_STATE:
		_true_reload()

func print_logo() -> void:
	var c1 := Color.DEEP_SKY_BLUE
	var c2 := Color.GOLDENROD
	var logo := ""
	for row in LOGO.format({version="0.1"}).trim_prefix("\n").trim_suffix("\n").split("\n"):
		var i := 0
		for col in row:
			logo += "[color=#%s]%s[/color]" % [c1.lerp(c2, i / 54.0).to_html(), col]
			i += 1
		logo += "\n"
	print_rich(logo)

func _ready() -> void:
	print_logo()
	reload()

func add_pauser(obj: Object):
	if obj in _pausers: return
	_pausers.append(obj)
	if _pausers.size() == 1:
		_pause.call_deferred()

func remove_pauser(obj: Object):
	if not obj in _pausers: return
	_pausers.erase(obj)
	if _pausers.size() == 0:
		_unpause.call_deferred()

func _pause():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused.emit()
	
func _unpause():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	unpaused.emit()

func reload():
	_loaded = false
	objects = StateObjects.new()
	
	var mods := Mods.get_enabled()
	var code := []
	
	var cinema_dir := "res://assets/cinematics"
	var conds: Dictionary[int, String]
	var exprs: Dictionary[int, String]
	for file in DirAccess.get_files_at(cinema_dir):
		if file.get_extension() == "tres":
			var fs: FlowScript = load(cinema_dir.path_join(file))
			fs.collect_expressions(conds, exprs)
	
	for mod: ModInfo in mods:
		conds.merge(mod._script_conds)
		exprs.merge(mod._script_exprs)
	
	# Compile conditions script.
	for hash_index in exprs:
		var expr := exprs[hash_index]
		if "\n" in expr:
			code.append("func _expr_%s() -> void:\n\t%s" % [hash_index, expr.replace("\n", "\n\t")])
		else:
			code.append("func _expr_%s() -> void: %s" % [hash_index, expr])
	for hash_index in conds:
		var cond := conds[hash_index]
		if not cond: cond = "true" # TODO: Fix.
		code.append("func _cond_%s() -> bool: return %s" % [hash_index, cond])
	
	for mod: ModInfo in mods:
		for db in mod.get_dbs():
			var db_id := UObj.get_class_name(db).trim_suffix("DB").to_snake_case().to_lower() + "s"
			code.append("\n####\n## %s x%s\n####" % [db_id.to_upper(), db.size()])
			for obj in db._objects.values():
				var prop_id: String = obj.id.replace("#", "__")
				if "#" in obj.id: continue
				if obj is StatInfo:
					var prop_type: String = type_string(typeof(obj.default))
					code.append("var %s: %s:\n\tget: return %s[&\"%s\"].value\n\tset(v): %s[&\"%s\"].value = v" % [prop_id, prop_type, db_id, obj.id, db_id, obj.id])
				else:
					var prop_class: String = UObj.get_class_name(obj)
					code.append("var %s: %s:\n\tget: return %s[&\"%s\"]" % [prop_id, prop_class, db_id, obj.id])
	
	var scr := GDScript.new()
	code = [
		"# WARNING: Autogenerated in StateBase",
		"# Allows making sure all flow_script variables and functions will work.",
		"# TODO: Show stats here, like 'lines spoken' for each character.",
		"extends StateBase"
	] + code
	scr.source_code = "\n".join(code)
	ResourceSaver.save(scr, PATH_AUTOGEN_STATE)
	set_script.call_deferred(load(PATH_AUTOGEN_STATE))
	
	Global.msg("State", "Reloading script...")
	
func find_char(id: StringName) -> CharInfo: return objects.chars.find(id)
func find_item(id: StringName) -> ItemInfo: return objects.items.find(id)
func find_zone(id: StringName) -> ItemInfo: return objects.zones.find(id)
func find_equipment_slot(id: StringName) -> EquipmentSlotInfo: return objects.equipment_slots.find(id)
func find_attribute(id: StringName) -> AttributeInfo: return objects.attributes.find(id)
func find_quest(id: StringName) -> QuestInfo: return objects.quests.find(id)
	
func _get(property: StringName) -> Variant:
	for db in dbs:
		if db.has(property):
			return db.get(property)
	return null

func _set(property: StringName, value: Variant) -> bool:
	for db in dbs:
		if db.has(property):
			db.set(property, value)
			return true
	return false

func _cond(hash_index: int) -> bool: return call("_cond_%s" % hash_index)
func _expr(hash_index: int) -> Variant: return call("_expr_%s" % hash_index)
