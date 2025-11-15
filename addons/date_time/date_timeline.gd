@tool
class_name DateTimeline extends DateTime

signal occurred(id: StringName)

const DEFAULT_PERIODS := { &"Dawn": 0, &"Morning": 4, &"Day": 8, &"Dusk": 12, &"Evening": 16, &"Night": 20 }
const DEFAULT_SEASONS := { &"Spring": [ Month.MARCH, 20 ], &"Summer": [ Month.JUNE, 21 ], &"Autumn": [ Month.SEPTEMBER, 22 ], &"Winter": [ Month.DECEMBER, 21 ] }
@export var occurrences: Array[Occurrence]
@export var pause_on_occurrence := false
@export_storage var _pending: Array[Occurrence]
@export_storage var _advanced_ms: int

func add_periods(periods: Dictionary = DEFAULT_PERIODS, method := occurred.emit, rank := 0) -> Array[Occurrence]:
	var out: Array[Occurrence]
	for id in periods:
		out.append(add_daily(id, periods[id], 0, method, rank))
	return out

func add_seasons(seasons: Dictionary = DEFAULT_SEASONS, method := occurred.emit, rank := 100) -> Array[Occurrence]:
	var out: Array[Occurrence]
	for id in seasons:
		var md: Array = seasons[id]
		out.append(add_yearly(id, md[0], md[1], null, method, rank))
	return out

func add_default_holidays() -> void:
	# Fixed dates
	add_yearly(&"New Year's Day", Month.JANUARY, 1)
	add_yearly(&"Valentine's Day", Month.FEBRUARY, 14)
	add_yearly(&"St. Patrick's Day", Month.MARCH, 17)
	add_yearly(&"April Fools' Day", Month.APRIL, 1)
	add_yearly(&"Independence Day", Month.JULY, 4)
	add_yearly(&"Halloween", Month.OCTOBER, 31)
	add_yearly(&"Veterans Day", Month.NOVEMBER, 11)
	add_yearly(&"Christmas", Month.DECEMBER, 25)
	add_yearly(&"New Year's Eve", Month.DECEMBER, 31)
	
	# Relative dates
	add_yearly(&"Mother's Day", Month.MAY, 2, Weekday.SUNDAY) # 2nd Sunday
	add_yearly(&"Memorial Day", Month.MAY, -1, Weekday.MONDAY) # Last Monday
	add_yearly(&"Father's Day", Month.JUNE, 3, Weekday.SUNDAY) # 3rd Sunday
	add_yearly(&"Thanksgiving", Month.NOVEMBER, 4, Weekday.THURSDAY) # 4th Thursday

func add_yearly(id: StringName, m: Month, day_or_offset: int = 0, w: Variant = null, method := occurred.emit, rank := 0) -> Occurrence:
	if w == null:
		return add(id, [m, day_or_offset], MS_IN_YEAR, method, rank)
	else:
		return add(id, [m, day_or_offset, w], MS_IN_YEAR, method, rank)

func add_daily(id: StringName, hor: int, min := 0, method := occurred.emit, rank := 0) -> Occurrence:
	return add(id, hor * MS_IN_HOUR + min * MS_IN_MINUTE, MS_IN_DAY, method, rank)

func add(id: StringName, offset: Variant, interval_ms := MS_IN_YEAR, method := occurred.emit, rank: int = 0) -> Occurrence:
	assert((typeof(offset) == TYPE_INT)\
		or (typeof(offset) == TYPE_ARRAY and (offset.size() == 2 or offset.size() == 3)))
	var occ := Occurrence.new()
	occ.id = id
	occ.offset = offset
	occ.rank = rank
	occ.interval_ms = interval_ms
	occ.method = method
	occ.recache(self)
	occurrences.append(occ)
	return occ

func find(id: StringName) -> Occurrence:
	for occ in occurrences:
		if occ.id == id:
			return occ
	return null

func is_caught_up() -> bool:
	return _pending.is_empty()

func catchup() -> void:
	if is_caught_up():
		push_warning("Already caught up. Call advance() instead.")
		return
	_popoff()

func advance(delta_ms: int) -> void:
	if delta_ms <= 0:
		return
	
	if pause_on_occurrence and not is_caught_up():
		return
	
	_pending.clear()
	var start_ms := total_milliseconds
	var end_ms := start_ms + delta_ms
	
	for occ in occurrences:
		if occ.next_ms > start_ms and occ.next_ms <= end_ms:
			_pending.append(occ)
			
	if _pending.is_empty():
		total_milliseconds = end_ms
		return
	
	_advanced_ms = end_ms
	_pending.sort_custom(_sort_occurrences)
	_popoff()

func _popoff() -> void:
	while not _pending.is_empty():
		var occ := _pending.pop_front()
		if _pending.is_empty():
			total_milliseconds = _advanced_ms
			_advanced_ms = 0
		else:
			total_milliseconds = occ.next_ms
		occ.sig.emit(occ.id)
		occ.recache(self)
		if occ.loops != -1:
			if occ.loops == 0:
				occurrences.erase(occ)
			else:
				occ.loops -= 1
		if pause_on_occurrence:
			return

static func _sort_occurrences(a: Occurrence, b: Occurrence) -> bool:
	if a.next_ms == b.next_ms:
		return a.rank > b.rank
	return a.next_ms < b.next_ms

func _ms_for_occurrence(occ: Occurrence, y: int) -> int:
	var offset := occ.offset
	
	# (A) Modular millisecond events: simple interval stepping
	if typeof(offset) == TYPE_INT:
		return occ._ms_from_modular(self)
	
	# (B) Absolute date [month, day]
	if offset.size() == 2:
		return _get_ms_from_date(y, offset[0], offset[1])
	
	# (C) Relative weekday [month, n, weekday]
	var m: Month = offset[0]
	var n: int = offset[1]      # e.g., +1 = first, -1 = last
	var wd: Weekday = offset[2]
	
	var days := _days_in_month(y, m)
	var found := -1

	if n > 0:
		var count := 0
		for d in range(1, days + 1):
			if _get_weekday(y, m, d) == wd:
				count += 1
				if count == n:
					found = d
					break
	else:
		var count := 0
		for d in range(days, 0, -1):
			if _get_weekday(y, m, d) == wd:
				count -= 1
				if count == n:
					found = d
					break

	if found == -1:
		return INF

	return _get_ms_from_date(y, m, found)

static func _year_start_ms(y: int) -> int:
	return _get_days_from_date(y, Month.JANUARY, 1) * MS_IN_DAY

class Occurrence extends Resource:
	@export var id: StringName
	@export var offset: Variant # int OR [m,d] OR [m,off,wk]
	@export var interval_ms: int
	@export var next_ms: int
	@export var rank: int
	@export var method: Callable
	@export var loops := -1 ## -1 is infinite.
	
	func onetime() -> Occurrence:
		loops = 1
		return self
	
	func _ms_from_modular(tl: DateTimeline) -> int:
		var cur := tl.total_milliseconds
		var base: int = cur - (cur % interval_ms) + offset
		if base <= cur:
			base += interval_ms
		return base
	
	func recache(tl: DateTimeline) -> void:
		var cur := tl.total_milliseconds
		
		# Case 1: modular interval
		if typeof(offset) == TYPE_INT:
			next_ms = _ms_from_modular(tl)
			return
		
		# Case 2: yearly events (absolute or relative)
		var y := tl._get_year_from_ms(cur)
		var hit := tl._ms_for_occurrence(self, y)
		if hit <= cur:
			hit = tl._ms_for_occurrence(self, y + 1)
		next_ms = hit
