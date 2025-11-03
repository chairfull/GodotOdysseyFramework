@tool
extends Node3D

@export var humanoid: Humanoid: set=set_humanoid
@export var highlightable: Array[MeshInstance3D]
@export var highlight := false: set=set_highlight
@onready var _tree: AnimationTree = %animation_tree
var _walk_blend := 0.0
var _highlight_material: Material

func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)

func set_humanoid(h: Humanoid):
	humanoid = h
	if not humanoid:
		set_process(false)
		return
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
	humanoid.looked_at.connect(func(at: Vector3): %lookat_head.global_position = at)
	humanoid.interactive_node.highlight_changed.connect(func():
		match humanoid.interactive_node.highlight:
			Interactive.Highlight.NONE: highlight = false
			Interactive.Highlight.FOCUSED: highlight = true
		)
	humanoid.trigger_animation.connect(travel)
	
func set_highlight(h: bool):
	highlight = h
	if highlight:
		_highlight_material = load("res://assets/materials/highlighted.tres")
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

func travel(to: StringName):
	print("TRAVEL ", to)
	var sm: AnimationNodeStateMachinePlayback = _tree.get(&"parameters/main/playback")
	sm.travel(to)

func _process(delta: float) -> void:
	if not humanoid: return
	_walk_blend = lerpf(_walk_blend, humanoid.movement.length(), 15.0 * delta)
	_tree.set(&"parameters/main/Standing/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crouching/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crawling/blend_position", _walk_blend)
