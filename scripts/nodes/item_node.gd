class_name ItemNode extends RigidBody3D

#signal damage_dealt(info: DamageInfo)

@export var id: StringName
@export var info: ItemInfo:
	get: return info if info else State.find_item(id)
@export_custom(PROPERTY_HINT_EXPRESSION, "") var debug_properties_yaml: String
@export var highlight := false: set=set_highlight
@export var highlightable: Array[Node3D]
@export var state: Dictionary[StringName, Variant]
@onready var animation_player: AnimationPlayer = %animation_player
@onready var animation_tree: AnimationTree = %animation_tree
@onready var interactive: Interactive = %interactive
var _highlight_material: Material
var _reset_state := false
var _reset_transform: Transform3D
var _holder: CharNode
var _remote: RemoteTransform3DTweened
var _widgit: ItemWidget

func _ready() -> void:
	var yaml := YAML.parse(debug_properties_yaml)
	if not yaml.has_error():
		var props: Variant = yaml.get_data()
		if props is Dictionary:
			UObj.set_properties(self, props)
	interactive.highlight_changed.connect(_highlight_changed)
	interactive.interacted.connect(_interacted)
	interactive.can_interact = _can_interact
	update_label()

func try_show_widgit(widgit_id: StringName) -> bool:
	if get_holder().is_controlled():
		_widgit = get_holder().get_controller().show_widgit(widgit_id, { node=self }, true)
		_widgit.refresh()
		return true
	return false

func try_hide_widgit() -> bool:
	if _widgit:
		_widgit.close_transitioned()
		_widgit = null
		return true
	return false

func update_label() -> void:
	if info:
		interactive.label = info._node_get_label(self)

func refresh_widgit() -> void:
	if _widgit:
		_widgit.refresh()

func get_holder() -> CharNode:
	return _holder

func is_equipped() -> bool:
	return _holder != null

func _equipped(to: CharNode, bone: Node3D) -> void:
	#interactive.
	process_mode = Node.PROCESS_MODE_DISABLED
	_holder = to
	_remote = RemoteTransform3DTweened.new()
	bone.add_child(_remote)
	_remote.tween_duration = 0.2
	_remote.set_node(self)
	
	if info:
		info._node_equipped(self)
	
	freeze = true
	sleeping = true
	collision_layer = 0
	for h in highlightable:
		if "layers" in h:
			h.layers = 1 << 1
		if "material_overlay" in h:
			h.material_overlay = null
	highlight = false

func _unequipped() -> void:
	#interactive.
	process_mode = Node.PROCESS_MODE_INHERIT
	if info:
		info._node_unequipped(self)
	
	_holder = null
	_remote.get_parent().remove_child(_remote)
	_remote.queue_free()
	_remote = null
	
	freeze = false
	sleeping = false
	collision_layer = 1 << 1
	for h in highlightable:
		if "layers" in h:
			h.layers = 1 << 0
	
	var trans := global_transform
	var fwd: Vector3 = -global_basis.z
	trans.origin += fwd * .2
	reset_state(trans)
	apply_central_impulse(fwd * 3.0)

func _highlight_changed():
	highlight = interactive.highlight == Interactive.Highlight.FOCUSED

func set_highlight(h: bool):
	highlight = h
	if highlight and not is_equipped():
		_highlight_material = Assets.get_material(&"highlighted").duplicate_deep()
		_highlight_material.albedo_color.a = 0.0
		_highlight_material.stencil_color.a = 0.0
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.2,
			"_highlight_material:stencil_color:a": 1.0 }, 0.2)
		for mesh in highlightable:
			mesh.material_overlay = _highlight_material
	elif _highlight_material:
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.0,
			"_highlight_material:stencil_color:a": 0.0 }, 0.2)\
		.finished.connect(func():
			for mesh in highlightable:
				mesh.material_overlay = null
			_highlight_material = null)

func _can_interact(pawn: Pawn) -> bool:
	return pawn is CharNode

func _interacted(pawn: Pawn, _form: Interactive.Form):
	(pawn as CharNode).equip(self)

func anim_travel(anim_id: StringName):
	var playback: AnimationNodeStateMachinePlayback = animation_tree.get(&"parameters/playback")
	playback.travel(anim_id)

func _integrate_forces(physics_state: PhysicsDirectBodyState3D) -> void:
	if _reset_state:
		physics_state.transform = _reset_transform
		_reset_state = false

func reset_state(trans: Transform3D):
	_reset_state = true
	_reset_transform = trans
