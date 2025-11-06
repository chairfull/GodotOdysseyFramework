class_name DetectableSound extends Area3D

static func create(sound: StringName, at: Vector3, distance := 5.0, duration := 1.0) -> DetectableSound:
	var node: DetectableSound = Assets.create_prefab(&"detectable_sound")
	Global.get_tree().current_scene.add_child(node)
	node.name = "detsound_" + sound
	node.global_position = at
	var strm: AudioStreamPlayer3D = node.get_node(^"%stream")
	strm.max_distance = distance
	strm.stream = load(Assets.get_sound(sound))
	var shape: CollisionShape3D = node.get_node(^"%shape")
	shape.shape = SphereShape3D.new()
	shape.shape.radius = distance
	Global.wait(duration, node.queue_free)
	return node
