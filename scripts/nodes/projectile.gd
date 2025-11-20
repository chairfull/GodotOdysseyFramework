class_name Projectile extends Node3D

static func create(ignore: Array[RID], at: Vector3, to: Vector3, speed := 1.0, shape := false) -> Projectile:
	var node: Node3D = (ShapeCast3D if shape else RayCast3D).new()
	node.set_script(Projectile)
	Global.get_tree().current_scene.add_child(node)
	node.global_position = at
	node.dir = (to - at).normalized()
	node.spd = speed
	if shape:
		var shp: ShapeCast3D = node
		shp.shape = SphereShape3D.new()
	else:
		var ray: RayCast3D = node
		ray.collide_with_areas = true
		ray.collision_mask = (1 << 0) | (1 << 10) ## Collides with Solid and Damageable
		ray.target_position = node.dir * speed
	for obj in ignore:
		node.add_exception_rid(obj)
	return node as Object

var dir := Vector3.FORWARD
var spd := 1.0

func _process(_delta: float) -> void:
	if call(&"is_colliding"):
		set_process(false)
		global_position = call(&"get_collision_point")
		var obj: Object = call(&"get_collider")
		if obj is Damageable:
			obj.damage(10.0)
		elif obj.owner and obj.owner.has_method(&"_hit"):
			obj.owner._hit(obj, self)
		elif obj.owner.owner and obj.owner.owner.has_method(&"_hit"):
			obj.owner.owner._hit(obj, self)
		else:
			push_error("No _hit() on %s or it's parents." % [obj])
		await get_tree().create_timer(1.0).timeout
		queue_free()
	else:
		global_position += dir * spd
