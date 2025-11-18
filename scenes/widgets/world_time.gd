extends Widget

func _ready() -> void:
	State.time.changed.connect(_refresh)
	_refresh()

func _refresh() -> void:
	var wt := State.time
	%label.text = "{x}\nTime: {hour}:{minute}:{second}\nDay: {day} Mon: {month} Year: {year}".format({x="?",
		hour=wt.hour, minute=wt.minute, second=wt.second,
		day=wt.day, month=wt.month, year=wt.year})
