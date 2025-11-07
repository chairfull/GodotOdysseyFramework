class_name Equipment extends Inventory

signal item_equipped(slot: EquipmentSlotInfo, item: InventoryItem)
signal item_unequipped(slot: EquipmentSlotInfo, item: InventoryItem)
signal equipment_changed()

@export var wearing: Dictionary[StringName, InventoryItem]

func is_wearing(slot: StringName) -> bool:
	return slot in wearing

func can_equip(item: InventoryItem, slot_id: StringName = &"") -> bool:
	return slot_id in item.item_info.wear_to

func equip(item: InventoryItem, slot_id: StringName = &""):
	if not can_equip(item, slot_id):
		push_error("Can't equip %s to %s on %s." % [item, slot_id, self])
		return
		
	var slot_info := State.find_equipment_slot(slot_id)
	var bare: Array[StringName]
	bare.append_array(slot_info.bare)
	
	# Unequip if occupied.
	if is_wearing(slot_id):
		bare.append(slot_id)
	
	# Unequip all slots.
	for sid in bare:
		unequip_slot(sid)
	
	var slot_index := items.find(item)
	if slot_index != -1:
		items.remove_at(slot_index)
	
	wearing[slot_id] = item
	item_equipped.emit(slot_info, item)
	equipment_changed.emit()

func unequip_slot(slot_id: StringName):
	if not slot_id in wearing:
		return
	var slot_info := State.find_equipment_slot(slot_id)
	var item := wearing[slot_id]
	wearing.erase(slot_id)
	items.append(item)
	item_unequipped.emit(slot_info, item)
	equipment_changed.emit()
