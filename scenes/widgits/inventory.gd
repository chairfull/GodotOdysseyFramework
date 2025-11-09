extends Widget

@onready var slot_parent: Control = %slots
@onready var slot_prefab: Control = %slot_prefab

func _ready() -> void:
	slot_parent.remove_child(slot_prefab)
	
	await get_tree().process_frame
	
	var inv := Inventory.new()
	inv.gain_everything()
	
	for item: InventoryItem in inv:
		var btn: Control = slot_prefab.duplicate()
		btn.name = item.item
		btn.get_node("%label").text = item.item
		slot_parent.add_child(btn)
		
	slot_parent.selected.connect(_selected)
	
	if slot_parent.get_child_count() > 0:
		(slot_parent.get_child(0) as Control).grab_focus.call_deferred()

func _selected(node: Node):
	print(node)
	Global.wait(1.5, get_tree().quit)
