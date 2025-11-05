class_name ShooterInfo extends ItemInfo

@export var max_ammo: int = 16
@export var projectile_item_id: StringName

func _node_equipped(node: ItemNode) -> bool:
	if not node._state:
		node._state.ammo = max_ammo
		node._state.max_ammo = max_ammo
	return true

func _node_unequipped(_node: ItemNode) -> bool:
	return true

func _node_use(node: ItemNode) -> bool:
	if node.mount is Humanoid:
		if node._state.ammo > 0:
			#var hum: Humanoid = node.mount
			var from: Vector3 = node.get_node("%projectile_spawn").global_position
			var to := (node.mount as Humanoid).looking_at
			var proj := Projectile.create(from, to)
			var sphere := SphereMesh.new()
			sphere.height = 0.2
			sphere.radius = sphere.height * .5
			var mesh := MeshInstance3D.new()
			proj.add_child(mesh)
			mesh.mesh = sphere
			
			node.anim_travel("fire")
			node._state.ammo -= 1
			print("%s/%s" % [node._state.ammo, node._state.max_ammo])
			return true
		else:
			print("No ammo left.")
	return false

func _node_reload(node: ItemNode) -> bool:
	node.anim_travel("reload")
	node._state.ammo = max_ammo
	print("%s/%s" % [node._state.ammo, node._state.max_ammo])
	return true
