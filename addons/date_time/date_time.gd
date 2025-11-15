@tool
class_name DateTime extends Resource

enum Meridiem { AM, PM }
enum Weekday { SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY }
enum Month { JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER }
enum Era { BC, AD }
enum Relation { PAST, PRESENT, FUTURE }
enum Epoch { MILLISECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, YEAR, DECADE, CENTURY }

const WEEKEND: PackedInt32Array = [ Weekday.SATURDAY, Weekday.SUNDAY ]
const DAYS_IN_MONTH: PackedInt32Array = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
const DAYS_UNTIL_MONTH: PackedInt32Array = [ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 ] # Non leap-year.

const SECONDS_IN_MINUTE := 60
const MINUTES_IN_HOUR := 60
const HOURS_IN_DAY := 24
const DAYS_IN_YEAR := 365
const DAYS_IN_WEEK := 7
const MONTHS_IN_YEAR := 12
const YEARS_IN_DECADE := 10
const YEARS_IN_CENTURY := 100
const MS_IN_SECOND := 1_000
const MS_IN_MINUTE := 60_000  # MS_IN_SECOND * SECONDS_IN_MINUTE
const MS_IN_HOUR := 3_600_000  # MS_IN_MINUTE * MINUTES_IN_HOUR
const MS_IN_DAY := 86_400_000  # MS_IN_HOUR * HOURS_IN_DAY
const MS_IN_WEEK := 604_800_000  # MS_IN_DAY * DAYS_IN_WEEK
const MS_IN_YEAR := 31_536_000_000  # MS_IN_DAY * DAYS_IN_YEAR
const MS_IN_DECADE := 315_360_000_000  # MS_IN_YEAR * YEARS_IN_DECADE
const MS_IN_CENTURY := 3_153_600_000_000  # MS_IN_YEAR * YEARS_IN_CENTURY

@export var total_milliseconds: int = 0: set=set_total_milliseconds
var total_seconds: int: set=set_total_seconds, get=get_total_seconds
var total_minutes: int: set=set_total_minutes, get=get_total_minutes
var total_hours: int: set=set_total_hours, get=get_total_hours
var total_days: int: set=set_total_days, get=get_total_days
var total_years: int: set=set_total_years, get=get_total_years
var total_decades: int: get=get_total_decades
var total_centuries: int: get=get_total_centuries

var millisecond: int: get=get_millisecond
var second: int: set=advance_to_second, get=get_second
var minute: int: set=advance_to_minute, get=get_minute
var hour: int: set=advance_to_hour, get=get_hour
var meridiem: Meridiem: get=get_meridiem

var day: int: set=advance_to_day, get=get_day
var weekday: Weekday: get=get_weekday, set=advance_to_weekday
var weekday_name: String: set=advance_to_weekday_name, get=get_weekday_name
var month: Month: set=advance_to_month, get=get_month
var month_name: String: set=advance_to_month_name, get=get_month_name
var year: int: set=advance_to_year, get=get_year
var era: Era: get=get_era
var era_year: int: get=get_era_year

func set_total_milliseconds(ms: int) -> void:
	if total_milliseconds == ms: return
	total_milliseconds = ms
	changed.emit()

func _next_unit(unit_ms: int) -> void:
	total_milliseconds += unit_ms - _positive_mod(total_milliseconds, unit_ms)

func _prev_unit(unit_ms: int) -> void:
	var rem := _positive_mod(total_milliseconds, unit_ms)
	total_milliseconds -= unit_ms if rem == 0 else rem

func _set_total_unit(unit: int, amount: int) -> void: total_milliseconds = amount * unit + (total_milliseconds % unit)
func _get_total_unit(unit: int) -> int: return _floor_div(total_milliseconds, unit)
func _get_unit(unit: int, max_unit: int) -> int: return _positive_mod(_floor_div(total_milliseconds, unit), max_unit)

func _advance_to_unit(unit: int, max_unit: int, amount: int) -> void:
	assert(amount >= 0 and amount < max_unit)
	total_milliseconds += (amount - _get_unit(unit, max_unit)) * unit

func _back_to_unit(unit: int, max_unit: int, amount: int) -> void:
	assert(amount >= 0 and amount < max_unit)
	var delta := _positive_mod(_get_unit(unit, max_unit) - amount, max_unit)
	total_milliseconds -= (max_unit if delta == 0 else delta) * unit

#region Seconds, Minutes, Hours

# Millisecond
func get_millisecond() -> int: return _get_unit(1, MS_IN_SECOND)

# Seconds
func get_total_seconds() -> int: return _get_total_unit(MS_IN_SECOND)
func set_total_seconds(s: int) -> void: _set_total_unit(MS_IN_SECOND, s)
func advance_second() -> void: _next_unit(MS_IN_SECOND)
func back_second() -> void: _prev_unit(MS_IN_SECOND)
func get_second() -> int: return _get_unit(MS_IN_SECOND, SECONDS_IN_MINUTE)
func advance_to_second(s: int) -> void: _advance_to_unit(MS_IN_SECOND, SECONDS_IN_MINUTE, s)
func back_to_second(s: int) -> void: _back_to_unit(MS_IN_SECOND, SECONDS_IN_MINUTE, s)

# Minutes
func get_total_minutes() -> int: return _get_total_unit(MS_IN_MINUTE)
func set_total_minutes(m: int) -> void: _set_total_unit(MS_IN_MINUTE, m)
func advance_minute() -> void: _next_unit(MS_IN_MINUTE)
func back_minute() -> void: _prev_unit(MS_IN_MINUTE)
func get_minute() -> int: return _get_unit(MS_IN_MINUTE, MINUTES_IN_HOUR)
func advance_to_minute(m: int) -> void: _advance_to_unit(MS_IN_MINUTE, MINUTES_IN_HOUR, m)
func back_to_minute(m: int) -> void: _back_to_unit(MS_IN_MINUTE, MINUTES_IN_HOUR, m)

# Hours
func get_total_hours() -> int: return _get_total_unit(MS_IN_HOUR)
func set_total_hours(h: int) -> void: _set_total_unit(MS_IN_HOUR, h)
func advance_hour() -> void: _next_unit(MS_IN_HOUR)
func back_hour() -> void: _prev_unit(MS_IN_HOUR)
func get_hour() -> int: return _get_unit(MS_IN_HOUR, HOURS_IN_DAY)
func advance_to_hour(h: int) -> void: _advance_to_unit(MS_IN_HOUR, HOURS_IN_DAY, h)
func back_to_hour(h: int) -> void: _back_to_unit(MS_IN_HOUR, HOURS_IN_DAY, h)

func get_meridiem() -> Meridiem: return Meridiem.AM if hour < 12 else Meridiem.PM

#endregion

#region Days

func get_total_days() -> int: return _get_total_unit(MS_IN_DAY)
func set_total_days(d: int) -> void: _set_total_unit(MS_IN_DAY, d)
func advance_day() -> void: _next_unit(MS_IN_DAY)
func back_day() -> void: _prev_unit(MS_IN_DAY)

func get_day() -> int: return get_date()[2]

func get_day_of_year() -> int:
	var d := get_total_days()
	var y := get_year()
	var leaps := _get_leap_days_up_to_year(y)
	return d - (y * DAYS_IN_YEAR + leaps)

## Hours, minutes, seconds, & milliseconds.
func get_time_ms() -> int:
	return _positive_mod(total_milliseconds, MS_IN_DAY)

func set_time(hour_ := 0, minute_ := 0, second_ := 0, millisecond_ := 0) -> void:
	var days := _get_days_from_date(get_year(), get_month(), get_day())
	total_milliseconds = days * MS_IN_DAY\
		+ hour_ * MS_IN_HOUR\
		+ minute_ * MS_IN_MINUTE\
		+ second_ * MS_IN_SECOND\
		+ millisecond_

func advance_to_day(d: int) -> void:
	assert(d >= 1 and d <= 31)
	var y := get_year()
	var m := get_month()
	var cur_d := get_day()
	var dim := _days_in_month(y, m)
	var target_d := mini(d, dim)
	if target_d > cur_d:
		set_date(y, m, target_d)
	else:
		# next month
		var nm := m + 1
		var ny := y
		if nm > 11:
			nm = 0
			ny += 1
		set_date(ny, nm, mini(d, _days_in_month(ny, nm)))

func back_to_day(d: int) -> void:
	assert(d >= 1 and d <= 31)
	var y := get_year()
	var m := get_month()
	var cur_d := get_day()
	var target_d := mini(d, _days_in_month(y, m))
	if target_d < cur_d:
		set_date(y, m, target_d)
	else:
		# previous month
		var pm := m - 1
		var py := y
		if pm < 0:
			pm = 11
			py -= 1
		set_date(py, pm, mini(d, _days_in_month(py, pm)))

func get_total_weeks() -> int: return _get_total_unit(MS_IN_WEEK)

# Sakamoto's algorithm
func get_weekday() -> Weekday: return _get_weekday(get_year(), get_month(), get_day())

func advance_to_weekday(w: Weekday) -> void:
	assert(w in Weekday.values())
	var cur := get_weekday()
	var delta := (int(w) - cur + DAYS_IN_WEEK) % DAYS_IN_WEEK
	if delta == 0:
		delta = DAYS_IN_WEEK
	total_milliseconds += delta * MS_IN_DAY

func back_to_weekday(w: Weekday) -> void:
	assert(w in Weekday.values())
	var cur := get_weekday()
	var delta := (cur - int(w) + DAYS_IN_WEEK) % DAYS_IN_WEEK
	if delta == 0:
		delta = DAYS_IN_WEEK
	total_milliseconds -= delta * MS_IN_DAY

func get_weekday_name() -> String: return Weekday.keys()[get_weekday()]

func advance_to_weekday_name(n: String) -> void:
	var idx := Weekday.keys().find(n)
	assert(idx != -1, "Unknown weekday: %s" % n)
	advance_to_weekday(idx as Weekday)

func back_to_weekday_name(n: String) -> void:
	var idx := Weekday.keys().find(n)
	assert(idx != -1, "Unknown weekday: %s" % n)
	back_to_weekday(idx as Weekday)

func is_weekend() -> bool: return WEEKEND.has(get_weekday())

func advance_weekend() -> void:
	var delta := (Weekday.SATURDAY - get_weekday() + DAYS_IN_WEEK) % DAYS_IN_WEEK
	total_milliseconds += (DAYS_IN_WEEK if delta == 0 else delta) * MS_IN_DAY

func back_weekend() -> void:
	var delta := (get_weekday() - Weekday.SATURDAY + DAYS_IN_WEEK) % DAYS_IN_WEEK
	total_milliseconds -= (DAYS_IN_WEEK if delta == 0 else delta) * MS_IN_DAY

func advance_week() -> void: _next_unit(MS_IN_WEEK)
func back_week() -> void: _prev_unit(MS_IN_WEEK)

## Returns: [year: int, month: Month, day: int]
func get_date() -> Array[int]: return _get_date_from_days(get_total_days())

func set_date(year_: int, month_: int, day_: int) -> void:
	total_milliseconds = _get_days_from_date(year_, month_, day_) * MS_IN_DAY + get_time_ms()

#endregion

#region Month

func get_total_months() -> int: return get_year() * MONTHS_IN_YEAR + get_month()
func get_month() -> Month: return get_date()[1]
func get_month_name() -> String: return Month.keys()[get_month()]

func advance_to_month_name(mn: String) -> void:
	var idx := Month.keys().find(mn)
	assert(idx != -1, "Unknown month: %s" % mn)
	advance_to_month(idx as Month)

func back_to_month_name(mn: String) -> void:
	var idx := Month.keys().find(mn)
	assert(idx != -1, "Unknown month: %s" % mn)
	back_to_month(idx as Month)

func advance_to_month(target_m: Month) -> void:
	assert(target_m >= 0 and target_m < 12, "Invalid month")
	var current_m := get_month()
	var y := get_year()
	var d := get_day()
	var ny := y
	if target_m <= current_m:
		ny += 1
	# Snap to target, preserving day (clamped)
	set_date(ny, target_m, mini(d, _days_in_month(ny, target_m)))

func back_to_month(target_m: Month) -> void:
	assert(target_m >= 0 and target_m < 12, "Invalid month")
	var current_m := get_month()
	var y := get_year()
	var d := get_day()
	var py := y
	if target_m == current_m:
		py -= 1  # Loop to prev year if already on target
	elif target_m > current_m:
		py -= 1  # Prev year if later
	# Snap to target, preserving day (clamped)
	set_date(py, target_m, mini(d, _days_in_month(py, target_m)))

func _advance_month(dir: int = 1) -> void:
	var y := get_year()
	var m := get_month()
	var d := get_day()
	var nm := _positive_mod(m + dir, MONTHS_IN_YEAR)
	var ny := y + _floor_div(m + dir, MONTHS_IN_YEAR) if dir > 0 else y + _floor_div(m + dir - MONTHS_IN_YEAR + 1, MONTHS_IN_YEAR)
	if dir < 0 and m + dir < 0:
		ny -= 1
		nm = MONTHS_IN_YEAR + (m + dir)
	set_date(ny, nm, mini(d, _days_in_month(ny, nm)))

func advance_month() -> void: _advance_month(1)
func back_month() -> void: _advance_month(-1)

#region Year

func get_total_years() -> int: return _get_total_unit(MS_IN_YEAR)
func set_total_years(y: int) -> void: _set_total_unit(MS_IN_YEAR, y)

func get_year() -> int: return get_date()[0]

func advance_to_year(y: int) -> void:
	var days_in_target := DAYS_IN_YEAR + (1 if _is_leap_year(y) else 0)
	var final_doy := mini(get_day_of_year(), days_in_target - 1)
	var days := _get_days_from_date(y, 0, 1) + final_doy
	total_milliseconds = days * MS_IN_DAY + get_time_ms()

func back_to_year(y: int) -> void:
	var cur_m := get_month()
	var cur_d := get_day()
	var tod := get_time_ms()
	var candidate_days := _get_days_from_date(y, cur_m, mini(cur_d, _days_in_month(y, cur_m)))
	var current_days := get_total_days()
	if candidate_days < current_days:
		total_milliseconds = candidate_days * MS_IN_DAY + tod
	else:
		var py := y - 1
		var cd := _get_days_from_date(py, cur_m, mini(cur_d, _days_in_month(py, cur_m)))
		total_milliseconds = cd * MS_IN_DAY + tod

func advance_year() -> void: advance_to_year(get_year() + 1)
func back_year() -> void: back_to_year(get_year() - 1)
func get_total_decades() -> int: return _get_total_unit(MS_IN_DECADE)
func get_total_centuries() -> int: return _get_total_unit(MS_IN_CENTURY)
func get_era() -> Era: return Era.AD if get_year() >= 0 else Era.BC

func get_era_year() -> int:
	var y := get_year()
	return y if y >= 0 else 1 - y

#endregion

func get_epoch(e: Epoch) -> int:
	match e:
		Epoch.MILLISECOND: return total_milliseconds
		Epoch.SECOND: return get_total_seconds()
		Epoch.MINUTE: return get_total_minutes()
		Epoch.HOUR: return get_total_hours()
		Epoch.DAY: return get_total_days()
		Epoch.WEEK: return get_total_weeks()
		Epoch.MONTH: return get_total_months()
		Epoch.YEAR: return get_total_years()
		Epoch.DECADE: return get_total_decades()
		Epoch.CENTURY: return get_total_centuries()
	return 0

func get_difference(other: DateTime, epoch := Epoch.MILLISECOND) -> int:
	var a := get_epoch(epoch)
	var b := other.get_epoch(epoch)
	return b - a

func get_relation(other: DateTime, epoch := Epoch.MILLISECOND) -> Relation:
	var difference := get_difference(other, epoch)
	if difference > 0: return Relation.FUTURE
	elif difference < 0: return Relation.PAST
	return Relation.PRESENT

#region Static Helpers

static func _floor_div(a: int, b: int) -> int:
	# reliable floor division for negatives
	var q := int(a / b)
	if (a % b) != 0 and ((a < 0) != (b < 0)):
		q -= 1
	return q

static func _positive_mod(a: int, b: int) -> int:
	return (a % b + b) % b

static func _get_leap_days_up_to_year(y: int) -> int:
	var prev := y - 1
	return _floor_div(prev, 4) - _floor_div(prev, 100) + _floor_div(prev, 400)

static func _is_leap_year(y: int) -> bool:
	return (y % 4 == 0) and ((y % 100) != 0 or (y % 400) == 0)

static func _days_in_month(y: int, m: int) -> int:
	if m == Month.FEBRUARY:
		return 29 if _is_leap_year(y) else 28
	return DAYS_IN_MONTH[m]

static func _get_weekday(y: int, m: Month, d: int) -> Weekday:
	const t: PackedInt32Array = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
	var yy := y
	if m < 2:
		yy -= 1
	var w := (yy + _floor_div(yy, 4) - _floor_div(yy, 100) + _floor_div(yy, 400) + t[m] + d) % 7
	return w as Weekday

static func _get_year_from_ms(ms: int) -> int:
	return _get_date_from_days( _floor_div(ms, MS_IN_DAY))[0]

static func _get_date_from_days(days: int) -> Array[int]:
	# approximate year
	var y := _floor_div(days, DAYS_IN_YEAR)
	# adjust to find exact year
	while true:
		var leaps := _get_leap_days_up_to_year(y)
		var start := y * DAYS_IN_YEAR + leaps
		var year_length := DAYS_IN_YEAR + (1 if _is_leap_year(y) else 0)
		var end := start + year_length
		if days >= start and days < end:
			var day_of_year := days - start
			# find month
			var m := 0
			while m < 12:
				var dim := _days_in_month(y, m)
				if day_of_year < dim:
					var d := day_of_year + 1
					return [y, m, d]
				day_of_year -= dim
				m += 1
			# fallback (shouldn't happen)
			return [y, Month.DECEMBER, 31]
		if days < start:
			y -= 1
		else:
			y += 1
	return []

static func _get_ms_from_date(y: int, m: int, d: int) -> int:
	return _get_days_from_date(y, m, d) * MS_IN_DAY

# Convert Y,M,D to absolute days since epoch (0 = year 0 day 0)
static func _get_days_from_date(y: int, m: int, d: int) -> int:
	var leaps := _get_leap_days_up_to_year(y)
	var days := y * DAYS_IN_YEAR + leaps
	var offset := DAYS_UNTIL_MONTH[m]
	# add leap day if past feb in leap year
	if m > Month.FEBRUARY and _is_leap_year(y):
		offset += 1
	days += offset
	days += (d - 1) # day -> 0-based
	return days

#endregion
