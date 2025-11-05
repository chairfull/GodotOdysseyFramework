class_name ItemInfo extends DatabaseObject

var desc: String
var max_per_slot: int = 1_000_000_000:
	get: return 1 if is_special() else max_per_slot
var wear_to: PackedStringArray ## Equipment slots.
var cells: Array[Vector2i] = [Vector2i.ZERO] ## TODO: How wide and high it is.
var default_state: Dictionary[StringName, Variant] = {} ## Setting this will mark the item as a special one.
var scene_held: PackedScene

## [Currency]
## currency: StringName
## currency_amount: int
##
## [Shooter]
## max_ammo: int = 16
## projectile_item: StringName

var _properties: Dictionary[StringName, Variant]

func get_db() -> Database:
	return State.items

func _node_equipped(_node: ItemNode) -> bool: return true
func _node_unequipped(_node: ItemNode) -> bool: return true
func _node_use(_node: ItemNode) -> bool: return true
func _node_reload(_node: ItemNode) -> bool: return true

func _to_string() -> String:
	return "Item(%s:%s)" % [id, name]

func _get(property: StringName) -> Variant:
	return _properties.get(property)

func get_texture() -> Texture:
	var path := "res://assets/images/items/%s.png" % id
	if FileAccess.file_exists(path):
		return load(path)
	return null

## Max area the cells occupy.
## The cells array allows for non-rectangular shapes.
var cell_extents: Vector2i:
	get:
		var minn := Vector2i(INF, INF)
		var maxx := Vector2i(-INF, -INF)
		for cell in cells:
			for i in 2:
				minn[i] = mini(minn[i], cell[i])
				maxx[i] = maxi(maxx[i], cell[i])
		var diff := maxx - minn
		return diff

func is_special() -> bool:
	return default_state.size() > 0
