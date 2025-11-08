class_name Inventory extends DatabaseObject
# TODO: Allow sorting in grid format. Currently it's just a list.

## Sort all slots in the inventory.
enum Sort { 
	NAME_A, ## Name from A to Z.
	NAME_Z, ## Name from Z to A.
	MOST,	## Most to least.
	LEAST	## Least to most.
}

signal item_gained(id: ItemInfo, amount: int)
signal item_lost(id: ItemInfo, amount: int)

@export var items: Array[InventoryItem]
@export var vars := VarDB.new()

# TODO: var max_items: int
# TODO: var max_slots: int
# TODO: var max_weight: int
# TODO: var weight_scale: float # 0.0 -> 1.0 on how heavy.
# TODO: var block_items: Array[StringName]
# TODO: var block_types: Array[StringName]
# TODO: var allow_items: Array[StringName]
# TODO: var allow_types: Array[StringName]

func get_item_slot_count() -> int:
	return items.size()

func clear_items():
	items.clear()

func give_item(other: Inventory, item: Variant, amount := 1):
	if item is StringName:
		lose_item(item, amount)
		other.gain(item, amount)
	elif item is InventoryItem:
		items.erase(item)
		other._items.append(item)
		changed.emit()
		other.changed.emit()

func gain_everything():
	for item in State.objects.items:
		gain_item(item)

func gain_item(item_info: ItemInfo, state: Variant = null):
	var amount: int = state if state is int else 1
	var total_gained := 0
	
	if item_info.is_special():
		for i in amount:
			items.append(InventoryItem.new(item_info, state))
			total_gained += 1
	else:
		# Look for space in other slots.
		for slot in items:
			if slot.item_info == item_info:
				var space_left := slot.get_empty_space()
				var add_amount := mini(space_left, amount)
				slot.amount += add_amount
				changed.emit()
				amount -= add_amount
				total_gained += add_amount
		# Create new slots with remainder.
		if amount > 0:
			for i in ceili(amount / float(item_info.max_per_slot)):
				var add_amount := mini(item_info.max_per_slot, amount)
				items.append(InventoryItem.new(item_info, add_amount))
				changed.emit()
				amount -= add_amount
				total_gained += add_amount
	
	item_gained.emit(item_info, total_gained)

func _gain_stack(stack: InventoryItem):
	if stack is InventoryItem:
		items.append(stack)
	else:
		gain_item(stack.item_info, stack.amount)

func lose_item(item: ItemInfo, amount := 1):
	for i in range(len(items)-1, -1, -1):
		var slot := items[i]
		if slot.item_info == item:
			var sub_amount := mini(slot.amount, amount)
			slot.amount -= sub_amount
			changed.emit()
			amount -= sub_amount
			
			if slot.amount <= 0:
				items.remove_at(i)
				changed.emit()
	
	item_lost.emit(item, amount)

func count_items(item_info: ItemInfo) -> int:
	var total := 0
	for slot in items:
		if slot.item_info == item_info:
			total += slot.amount
	return total

func has_item(item_info: ItemInfo, amount := 1) -> bool:
	return count_items(item_info) >= amount

func sort_items(on: Sort = Sort.NAME_A):
	match on:
		Sort.NAME_A: items.sort_custom(func(a, b): return a.id < b.id)
		Sort.NAME_Z: items.sort_custom(func(a, b): return a.id > b.id)
		Sort.MOST: items.sort_custom(func(a, b): return a.amount > b.amount)
		Sort.LEAST: items.sort_custom(func(a, b): return a.amount < b.amount)
	changed.emit()

## Counts ItemInfoCurrency objects.
func count_currency(currency: StringName) -> int:
	var total := 0
	for slot in items:
		var item_info := slot.item_info
		if item_info._properties.get(&"currency", &"") == currency:
			var currency_amount: int = item_info._properties.get(&"currency_amount", 0)
			total += currency_amount * slot.amount
	return total
