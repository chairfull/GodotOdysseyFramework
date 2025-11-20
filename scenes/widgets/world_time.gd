extends Widget

func _ready() -> void:
	World.time.changed.connect(_refresh)
	_refresh()

func _refresh() -> void:
	var wt := World.time
	%label.text = "{x}\nTime: {hour}:{minute}:{second}\nDay: {day} Mon: {month} Year: {year}".format({x="?",
		hour=wt.hour, minute=wt.minute, second=wt.second,
		day=wt.day, month=wt.month, year=wt.year})
