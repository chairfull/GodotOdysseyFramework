class_name GameEvent extends Event

static var LOCATION_ENTERED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })
static var LOCATION_EXITED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })

static var QUEST_STARTED := GameEvent.new({ quest=QuestInfo })
static var QUEST_PASSED := GameEvent.new({ quest=QuestInfo })
static var QUEST_FAILED := GameEvent.new({ quest=QuestInfo })
static var QUEST_TICKED := GameEvent.new({ quest=QuestInfo })

func _init(props := {}) -> void:
	super(State.event, props)
