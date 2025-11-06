class_name ItemNode extends RigidBody3D

#signal damage_dealt(info: DamageInfo)

@export var item: ItemInfo
@export_custom(PROPERTY_HINT_EXPRESSION, "") var debug_properties_yaml: String
@export var _state: Dictionary[StringName, Variant]
@export var mount: Node3D: set=set_mount ## Humanoid or ItemMount.
@onready var animation_player: AnimationPlayer = %animation_player
@onready var animation_tree: AnimationTree = %animation_tree
@onready var interactive: Interactive = %interactive
@export var highlight := false: set=set_highlight
@export var highlightable: Array[Node3D]
var _highlight_material: Material
var _reset_state := false
var _reset_transform: Transform3D

func _ready() -> void:
	var yaml := YAML.parse(debug_properties_yaml)
	if not yaml.has_error():
		var props: Variant = yaml.get_data()
		if props is Dictionary:
			for prop in props:
				if prop in self:
					self[prop] = props[prop]
	
	interactive.highlight_changed.connect(_highlight_changed)
	interactive.interacted.connect(_interacted)
	interactive.can_interact = _can_interact

func _highlight_changed():
	highlight = interactive.highlight == Interactive.Highlight.FOCUSED

func set_highlight(h: bool):
	highlight = h
	if highlight and not mount:
		_highlight_material = Assets.get_material(&"highlighted")
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
	return pawn.node is Humanoid

func _interacted(pawn: Pawn, _form: Interactive.Form):
	if pawn.node is Humanoid:
		pawn.node.pickup(self)

func set_mount(to: Node3D):
	if mount == to: return
	mount = to
	if mount:
		freeze = true
		sleeping = true
		collision_layer = 0
		for h in highlightable:
			if "layers" in h:
				h.layers = 1 << 1
			if "material_overlay" in h:
				h.material_overlay = null
		highlight = false
	else:
		freeze = false
		sleeping = false
		collision_layer = 1 << 1
		for h in highlightable:
			if "layers" in h:
				h.layers = 1 << 0

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
