class_name Agent extends Controllable

signal damage_dealt(info: DamageInfo)
signal damage_taken(info: DamageInfo)

@onready var node_direction: Node3D = %direction
@onready var node_interact: Detector = %interact
@onready var node_seeing: Detector = %seeing
@onready var node_hearing: Detector = %hearing
@onready var nav_agent: NavigationAgent3D = %nav_agent
@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float: get=get_direction, set=set_direction
var _frozen := false
var movement := Vector2.ZERO
var body: CharacterBody3D = convert(self, TYPE_OBJECT)
var _equipped: Dictionary[StringName, ItemNode]

func _ready() -> void:
	# Transfer rotation to proper node.
	%direction.rotation.y = rotation.y
	rotation.y = 0
	if %nav_agent:
		(%nav_agent as NavigationAgent3D).navigation_finished.connect(func(): movement = Vector2.ZERO)
	if %damageable:
		(%damageable as Damageable).damaged.connect(damage_taken.emit)

func equip(item: ItemNode, slot: StringName = &""):
	_equipped[slot] = item
	var parent := get_node_or_null("%" + str(slot))
	if parent != null:
		if item.get_parent() == null:
			parent.add_child(item)
		else:
			item.reparent(parent)
	item.damage_dealt.connect(damage_dealt.emit)

func unequip_slot(slot: StringName = &""):
	if not slot in _equipped: return
	var item: ItemNode = _equipped[slot]
	item.damage_dealt.disconnect(damage_dealt.emit)
	_equipped.erase(slot)

func get_direction() -> float:
	return %direction.rotation.y

func set_direction(dir: float):
	%direction.rotation.y = dir

func freeze():
	_frozen = true

func unfreeze():
	_frozen = false
