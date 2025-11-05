class_name GameEvent extends Event

static var LOCATION_ENTERED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })
static var LOCATION_EXITED := GameEvent.new({ location=LocationInfo, character=CharacterInfo })

static var QUEST_STARTED := GameEvent.new({ quest=QuestInfo })
static var QUEST_PASSED := GameEvent.new({ quest=QuestInfo })
static var QUEST_FAILED := GameEvent.new({ quest=QuestInfo })
static var QUEST_TICKED := GameEvent.new({ quest=QuestInfo })

#static var PROP_CHANGED := GameEvent.new({ vary=PropInfo })

func _init(props := {}) -> void:
	pass
	#super(State.event, props)
