class_name GameEvent extends Event

static var LOCATION_ENTERED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })
static var LOCATION_EXITED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })

func _init(props := {}) -> void:
	super(State.event, props)
