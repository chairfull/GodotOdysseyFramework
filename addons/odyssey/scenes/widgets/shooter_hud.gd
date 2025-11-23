class_name ItemWidget extends Widget

var node: ItemNode: set=set_node
var holder: CharNode

func set_node(n: ItemNode) -> void:
	node = n
	holder = node.get_holder()

func refresh() -> void:
	if node.state.ammo == 0:
		%info_label.text = "%s\nAmmo: EMPTY" % [node.info.name]
	else:
		%info_label.text = "%s\nAmmo: %s/%s" % [node.info.name, node.state.ammo, node.info.max_ammo]
