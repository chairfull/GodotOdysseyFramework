class_name ItemNode extends Node3D

@export var item: Item
@export_custom(PROPERTY_HINT_EXPRESSION, "") var debug_properties_yaml: String
@export var state: Dictionary[StringName, Variant]
@export var mount: Node3D
@onready var animation_player: AnimationPlayer = %animation_player
@onready var animation_tree: AnimationTree = %animation_tree

func _ready() -> void:
	var yaml := YAML.parse(debug_properties_yaml)
	if not yaml.has_error():
		var props: Variant = yaml.get_data()
		if props is Dictionary:
			for prop in props:
				if prop in self:
					self[prop] = props[prop]

func anim_travel(anim_id: StringName):
	var playback: AnimationNodeStateMachinePlayback = animation_tree.get(&"parameters/playback")
	playback.travel(anim_id)
