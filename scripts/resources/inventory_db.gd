class_name InventoryDB extends Database

const EVENT_GAIN_ITEM := &"GAIN_ITEM"
const EVENT_LOSE_ITEM := &"LOSE_ITEM"
const ALL_EVENTS := [EVENT_GAIN_ITEM, EVENT_LOSE_ITEM]

func connect_signals() -> void:
	Cinema.event.connect(_cinema_event)

func _cinema_event(ev: StringName, data: String):
	var data_args := data # TODO
	match ev:
		EVENT_GAIN_ITEM: pass
		EVENT_LOSE_ITEM: pass

func get_object_script() -> GDScript:
	return Inventory
