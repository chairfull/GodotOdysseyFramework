class_name ItemNode extends Node3D

signal damage_dealt(info: DamageInfo)

@export var item: ItemInfo
@export_custom(PROPERTY_HINT_EXPRESSION, "") var debug_properties_yaml: String
@export var state: Dictionary[StringName, Variant]
@export var mount: Node3D: set=set_mount ## Humanoid or ItemMount.
@onready var animation_player: AnimationPlayer = %animation_player
@onready var animation_tree: AnimationTree = %animation_tree
@onready var interactive: Interactive = %interactive

func _ready() -> void:
	var yaml := YAML.parse(debug_properties_yaml)
	if not yaml.has_error():
		var props: Variant = yaml.get_data()
		if props is Dictionary:
			for prop in props:
				if prop in self:
					self[prop] = props[prop]
	
	interactive.interacted.connect(_interacted)
	interactive.can_interact = _can_interact

func _can_interact(con: Controllable) -> bool:
	return con is Humanoid

func _interacted(con: Controllable):
	if con is Humanoid:
		set_mount(con)

func set_mount(to: Node3D):
	mount = to
	if mount:
		process_mode = Node.PROCESS_MODE_DISABLED
		if mount is Humanoid:
			(mount as Humanoid).pickup(self)
	else:
		process_mode = Node.PROCESS_MODE_INHERIT

func anim_travel(anim_id: StringName):
	var playback: AnimationNodeStateMachinePlayback = animation_tree.get(&"parameters/playback")
	playback.travel(anim_id)
