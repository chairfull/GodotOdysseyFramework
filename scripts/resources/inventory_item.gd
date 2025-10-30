class_name InventoryItem extends Resource

@export var item: StringName
@export var amount: int
@export var state: Dictionary[StringName, Variant]

var item_info: ItemInfo:
	get: return State.find_item(item)
	set(itm): item = itm.item

func _init(itm: ItemInfo, amount_or_state: Variant = 1) -> void:
	item = itm.id
	if itm.is_special():
		for key in itm.default_state:
			state[key] = itm.default_state[key]
		if amount_or_state is Dictionary:
			for key in amount_or_state:
				state[key] = amount_or_state[key]
		else:
			push_error("Can't set state %s for %s." % [amount_or_state, itm])
	else:
		if amount_or_state is int:
			amount = amount_or_state
		else:
			push_error("Can't set amount %s for %s." % [amount_or_state, itm])

func _to_string() -> String:
	return "InventoryItem(%s x%s)" % [item, amount]

## Adds commas. If minimise == true: 1_000 to "1K"
func get_nice_amount(minimise := false) -> String:
	if minimise:
		return UStr.number_abbreviated(amount)
	return UStr.number_with_commas(amount)

func get_empty_space() -> int:
	return maxi(0, item_info.max_per_slot - amount)
