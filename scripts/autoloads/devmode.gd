class_name DevMode extends Node

## Cheatmode.
## Makes it easier to build/test.
static var on := true: set=set_on
static var click_position_3d: Vector3
static var click_position_2d: Vector2

static func set_on(o: bool):
	on = o
	
	var node := Global.get_tree().root.get_node_or_null("devmode")
	if on:
		if not node:
			node = DevMode.new()
			node.name = "devmode"
			Global.get_tree().root.add_child.call_deferred(node)
			Log.msg("DevMode", "Enabled", ["Mua", "hah", "hah", "hah"])
	else:
		if node:
			Global.get_tree().root.remove_child(node)
			node.queue_free()
			Log.msg("DevMode", "Disabled", ["Aww", "www"])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton\
	and event.button_index == MOUSE_BUTTON_RIGHT\
	and event.pressed:
		var hovered_node: Node = get_viewport().gui_get_hovered_control()
		var options: Array[Dictionary]
		click_position_2d = event.position
		
		if not hovered_node:
			var vp: Viewport = Global.get_tree().get_first_node_in_group("game_viewport")
			var cam := vp.get_camera_3d()
			var mouse_pos = vp.get_mouse_position()
			var from = cam.project_ray_origin(mouse_pos)
			var to = from + cam.project_ray_normal(mouse_pos) * 1000.0
			var space_state = cam.get_world_3d().direct_space_state
			var query := PhysicsRayQueryParameters3D.create(from, to)
			query.collide_with_areas = true
			var hit := space_state.intersect_ray(query)
			if hit:
				hovered_node = hit.collider
				click_position_3d = hit.position
				
				# Go for scene instead.
				if not hovered_node.has_meta(&"devmode_options") and not hovered_node.has_method(&"_get_devmode"):
					hovered_node = hovered_node.owner
			
		if not hovered_node:
			return
		
		if hovered_node.has_method(&"_get_devmode"):
			for op in hovered_node._get_devmode():
				if op is Dictionary:
					options.append(op)
				elif op is Callable:
					options.append({ text=op.get_method().capitalize(), call=op.call })
		if hovered_node.has_meta(&"devmode_options"):
			for op in hovered_node.get_meta(&"devmode_options"):
				if op is Dictionary:
					options.append(op)
				elif op is Callable:
					options.append({ text=op.get_method().capitalize(), call=op.call })
		
		if not options:
			return
		
		#Screen.display_as_flow(&"context_menu", { options=options, hovered=hovered_node })
