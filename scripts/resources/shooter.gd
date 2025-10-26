class_name Shooter extends Item

@export var max_ammo: int = 16
@export var projectile_item_id: StringName

func _node_equipped(node: ItemNode):
	if not node.state:
		node.state.ammo = max_ammo
		node.state.max_ammo = max_ammo

func _node_use(node: ItemNode) -> bool:
	if node.mount is Humanoid:
		if node.state.ammo > 0:
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
			node.state.ammo -= 1
			print("%s/%s" % [node.state.ammo, node.state.max_ammo])
			return true
		else:
			print("No ammo left.")
	return false

func _node_reload(node: ItemNode) -> bool:
	node.anim_travel("reload")
	node.state.ammo = max_ammo
	print("%s/%s" % [node.state.ammo, node.state.max_ammo])
	return true
