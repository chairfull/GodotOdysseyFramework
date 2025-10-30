class_name Inventory extends DatabaseObject

## Sort all slots in the inventory.
enum Sort { 
	NAME_A, ## Name from A to Z.
	NAME_Z, ## Name from Z to A.
	MOST,	## Most to least.
	LEAST	## Least to most.
}

signal gained(id: ItemInfo, amount: int)
signal lost(id: ItemInfo, amount: int)

@export var _items: Array[InventoryItem]

func _init(frontmatter := {}):
	super(frontmatter)
	for key in frontmatter:
		var value: Variant = frontmatter[key]
		match key:
			"items":
				gain.call_deferred(value) # Call late, so items will exist.

func _iter_init(iter: Array) -> bool:
	iter[0] = 0
	return iter[0] < len(_items)

func _iter_next(iter: Array) -> bool:
	iter[0] += 1
	return iter[0] < len(_items)

func _iter_get(iter) -> InventoryItem:
	return _items[iter]

func clear():
	_items.clear()

func give(other: Inventory, item: Variant, amount := 1):
	if item is StringName:
		lose_item(item, amount)
		other.gain(item, amount)
	elif item is InventoryItem:
		_items.erase(item)
		other._items.append(item)
		changed.emit()
		other.changed.emit()

func gain_everything():
	for item in State.items:
		gain_item(item)

func gain(what: Variant, _amount := 1):
	match typeof(what):
		TYPE_DICTIONARY:
			for item_id in what:
				var item_info := State.find_item(item_id)
				if item_info:
					gain_item(item_info, what[item_id])

func gain_item(item_info: ItemInfo, state: Variant = null):
	var amount: int = state if state is int else 1
	var total_gained := 0
	
	if item_info.is_special():
		for i in amount:
			_items.append(InventoryItem.new(item_info, state))
			total_gained += 1
	else:
		# Look for space in other slots.
		for slot in _items:
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
				_items.append(InventoryItem.new(item_info, add_amount))
				changed.emit()
				amount -= add_amount
				total_gained += add_amount
	
	gained.emit(item_info, total_gained)

func _gain_stack(stack: InventoryItem):
	if stack is InventoryItem:
		_items.append(stack)
	else:
		gain_item(stack.item_info, stack.amount)

func lose_item(item: ItemInfo, amount := 1):
	for i in range(len(_items)-1, -1, -1):
		var slot := _items[i]
		if slot.item_info == item:
			var sub_amount := mini(slot.amount, amount)
			slot.amount -= sub_amount
			changed.emit()
			amount -= sub_amount
			
			if slot.amount <= 0:
				_items.remove_at(i)
				changed.emit()
	
	lost.emit(item, amount)

func count(item_info: ItemInfo) -> int:
	var total := 0
	for slot in _items:
		if slot.item_info == item_info:
			total += slot.amount
	return total

func has(item_info: ItemInfo, amount := 1) -> bool:
	return count(item_info) >= amount

func sort(on: Sort = Sort.NAME_A):
	match on:
		Sort.NAME_A: _items.sort_custom(func(a, b): return a.id < b.id)
		Sort.NAME_Z: _items.sort_custom(func(a, b): return a.id > b.id)
		Sort.MOST: _items.sort_custom(func(a, b): return a.amount > b.amount)
		Sort.LEAST: _items.sort_custom(func(a, b): return a.amount < b.amount)
	changed.emit()

## Counts ItemInfoCurrency objects.
func count_currency(currency: StringName) -> int:
	var total := 0
	for slot in _items:
		var item_info := slot.item_info
		if item_info._properties.get(&"currency", &"") == currency:
			var currency_amount: int = item_info._properties.get(&"currency_amount", 0)
			total += currency_amount * slot.amount
	return total
