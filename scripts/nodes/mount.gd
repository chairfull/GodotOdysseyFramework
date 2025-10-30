@tool
class_name Mount extends Node3D

@export var interactives: Array[Interactive]
@export var interactive: Interactive:
	get:
		return interactives[0] if interactives.size() > 0 else null
	set(inter):
		if interactives.size() == 0:
			interactives.append(inter)
		else:
			interactives[0] = inter

@export var mount_anim := &""

func _ready() -> void:
	for inter in interactives:
		inter.mounted.connect(_mounted)
		inter.unmounted.connect(_unmounted)

func _mounted(obj: Controllable):
	obj.global_position = global_position
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	
	if obj is Humanoid and mount_anim:
		obj.get_node(^"%animation_tree").travel(mount_anim)
	
func _unmounted(obj: Controllable):
	obj.process_mode = Node.PROCESS_MODE_INHERIT
	
	if obj is Humanoid and mount_anim:
		obj.get_node(^"%animation_tree").travel(&"Standing")
