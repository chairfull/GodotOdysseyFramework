class_name ShooterInfo extends ItemInfo

@export var max_ammo: int = 16
@export var projectile_item_id: StringName

func _node_get_label(node: ItemNode) -> String:
	if not node.state:
		node.state.ammo = max_ammo
	return "%s [%s/%s]" % [name, node.state.ammo, max_ammo]

func _node_equipped(node: ItemNode) -> bool:
	if not node.state:
		node.state.ammo = max_ammo
	node.try_show_widgit(Assets.WIDGIT_SHOOTER_HUD)
	return true

func _node_unequipped(node: ItemNode) -> bool:
	#node.interactive.label = "Gun [%s/%s]" % [node.state.ammo, node.state.max_ammo]
	node.try_hide_widgit()
	return true

func _node_use(node: ItemNode) -> bool:
	if node.get_holder() is CharNode:
		if node.state.ammo > 0:
			#var hum: Humanoid = node.mount
			var from: Vector3 = node.get_node("%projectile_spawn").global_position
			var to := node.get_holder().looking_at
			var proj := Projectile.create(from, to)
			var sphere := SphereMesh.new()
			sphere.height = 0.2
			sphere.radius = sphere.height * .5
			var mesh := MeshInstance3D.new()
			proj.add_child(mesh)
			mesh.mesh = sphere
			
			node.anim_travel("fire")
			node.state.ammo -= 1
			node.update_label()
			node.refresh_widgit()
			#print("%s/%s" % [node.state.ammo, node.state.max_ammo])
			return true
		else:
			print("No ammo left.")
	return false

func _node_reload(node: ItemNode) -> bool:
	node.anim_travel("reload")
	node.state.ammo = max_ammo
	node.update_label()
	node.refresh_widgit()
	#print("%s/%s" % [node.state.ammo, node.state.max_ammo])
	return true
