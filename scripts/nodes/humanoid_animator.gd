@tool
extends Node3D

@export var humanoid: Humanoid: set=set_humanoid
@export var highlightable: Array[MeshInstance3D]
@export var highlight_color := Color.YELLOW
@export var highlight := false: set=set_highlight
@onready var _tree: AnimationTree = %animation_tree
var _walk_blend := 0.0
var _highlight_material: Material

#region IK Properties
@export_range(0.0, 1.0) var ik_left_hand_influence := 0.0:
	get: return %ik_left_hand.influence
	set(w):
		if not is_inside_tree(): return
		%ik_left_hand.influence = clampf(w, 0.0, 1.0)
		%ik_left_hand.active = %ik_left_hand.influence != 0.0
@export_storage var ik_left_hand_position: Vector3:
	get: return %ik_left_hand.global_position
	set(p): if is_inside_tree(): %ik_left_hand.global_position = p

@export_range(0.0, 1.0) var ik_right_hand_influence := 0.0:
	get: return %ik_right_hand.influence
	set(w):
		if not is_inside_tree(): return
		%ik_right_hand.influence = clampf(w, 0.0, 1.0)
		%ik_right_hand.active = %ik_right_hand.influence != 0.0
@export_storage var ik_right_hand_position: Vector3:
	get: return %ik_right_hand.global_position
	set(p): if is_inside_tree(): %ik_right_hand.global_position = p
#
#@export_range(0.0, 1.0) var ik_left_foot_influence := 0.0:
	#get: return %ik_left_foot.influence
	#set(w):
		#if not is_inside_tree(): return
		#%ik_left_foot.influence = clampf(w, 0.0, 1.0)
		#%ik_left_foot.active = %ik_left_foot.influence != 0.0
#@export_storage var ik_left_foot_position: Vector3:
	#get: return %ik_left_foot.global_position
	#set(p): if is_inside_tree(): %ik_left_foot.global_position = p
#
#@export_range(0.0, 1.0) var ik_right_foot_influence := 0.0:
	#get: return %ik_right_foot.influence
	#set(w):
		#if not is_inside_tree(): return
		#%ik_right_foot.influence = clampf(w, 0.0, 1.0)
		#%ik_right_foot.active = %ik_right_foot.influence != 0.0
#@export_storage var ik_right_foot_position: Vector3:
	#get: return %ik_right_foot.global_position
	#set(p): if is_inside_tree(): %ik_right_foot.global_position = p
#endregion

func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)

func set_humanoid(h: Humanoid):
	humanoid = h
	if not humanoid:
		set_process(false)
		return
	if not Engine.is_editor_hint():
		_connect.call_deferred()

func _connect():
	set_process(not Engine.is_editor_hint())
	humanoid.jumped.connect(func(): travel(&"Jump"))
	humanoid.landed.connect(func(_m: float = 0.0): travel(&"Standing"))
	humanoid.prone_state_changed.connect(func():
		match humanoid.prone_state:
			Humanoid.ProneState.Stand: travel(&"Standing")
			Humanoid.ProneState.Crouch: travel(&"Crouching")
			Humanoid.ProneState.Crawl: travel(&"Crawling")
		)
	humanoid.head_looked_at.connect(func(at: Vector3): %lookat_head.global_position = at)
	humanoid.head_looking_amount_changed.connect(func(amount: float): %head.influence = amount)
	#humanoid.interactive_node.highlight_changed.connect(func():
		#match humanoid.interactive_node.highlight:
			#Interactive.Highlight.NONE: highlight = false
			#Interactive.Highlight.FOCUSED: highlight = true
		#)
	humanoid.trigger_animation.connect(travel)
	humanoid.equipped.connect(_equipped)
	humanoid.unequipped.connect(_unequipped)

func _equipped(item: ItemNode, slot_id: StringName) -> void:
	match slot_id:
		&"right_hand":
			var rt := RemoteTransform3D.new()
			item.add_child(rt)
			rt.name = "remote_right_hand"
			rt.remote_path = rt.get_path_to(%ik_right_hand_target)
			ik_right_hand_influence = 1.0

func _unequipped(item: ItemNode, slot_id: StringName) -> void:
	match slot_id:
		&"right_hand":
			var rt: RemoteTransform3D = item.get_node("remote_right_hand")
			item.remove_child(rt)
			rt.queue_free()
			ik_right_hand_influence = 0.0

func set_highlight(h: bool):
	highlight = h
	if highlight:
		_highlight_material = load("res://assets/materials/highlighted.tres")
		_highlight_material.albedo_color.a = 0.0
		_highlight_material.stencil_color.a = 0.0
		UTween.parallel(self, {
			"_highlight_material:albedo_color": Color(highlight_color, 0.2),
			"_highlight_material:stencil_color": Color(highlight_color, 1.0) }, 0.2)
		for mesh in highlightable:
			mesh.material_overlay = _highlight_material
	elif _highlight_material:
		UTween.parallel(self, {
			"_highlight_material:albedo_color": Color(highlight_color, 0.0),
			"_highlight_material:stencil_color": Color(highlight_color, 0.0) }, 0.2)\
		.finished.connect(func():
			for mesh in highlightable:
				mesh.material_overlay = null
			_highlight_material = null)

func travel(to: StringName):
	var sm: AnimationNodeStateMachinePlayback = _tree.get(&"parameters/main/playback")
	sm.travel(to)

func _process(delta: float) -> void:
	if not humanoid: return
	_walk_blend = lerpf(_walk_blend, humanoid.movement.length(), 15.0 * delta)
	_tree.set(&"parameters/main/Standing/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crouching/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crawling/blend_position", _walk_blend)
	
	
