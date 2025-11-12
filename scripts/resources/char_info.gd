class_name CharInfo extends Equipment

@export var desc: String
@export var zone: ZoneInfo
@export var following: CharInfo ## ID of Character being followed.
@export var occupying: StringName ## Furniture, vehicles, traps, machines...
@export var groups: Dictionary[StringName, StatDB]

func add_to_group(group: CharGroupInfo):
	groups[group.id] = StatDB.new()

func remove_from_group(group: CharGroupInfo):
	if not group.id in groups: return
	groups.erase(group.id)
