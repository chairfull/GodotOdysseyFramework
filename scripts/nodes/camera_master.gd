class_name CameraMaster extends Camera3D

@export var target: Camera3D: set=set_target
var _next_target: Camera3D
var _tween: Tween

static var ref: CameraMaster:
	get: return null if not Global.get_tree() else Global.get_tree().get_first_node_in_group(&"CameraMaster")

func _init() -> void:
	add_to_group(&"CameraMaster")

func _ready() -> void:
	make_current()

func set_target(t: Camera3D):
	if target == t or _next_target == t: return
	if target:
		_next_target = t
		var targ_basis := target.global_basis
		var targ_position := target.global_position
		var targ_offset := Vector2(target.h_offset, target.v_offset)
		var targ_fov := target.fov
		var targ_size := target.size
		var targ_range := Vector2(target.near, target.far)
		print("tween camera")
		if _tween: _tween.kill()
		_tween = create_tween()
		_tween.tween_method(func(blend: float):
			global_basis = targ_basis.slerp(t.global_basis, blend)
			global_position = targ_position.lerp(t.global_position, blend)
			h_offset = lerpf(targ_offset.x, t.h_offset, blend)
			v_offset = lerpf(targ_offset.y, t.v_offset, blend)
			fov = lerpf(targ_fov, t.fov, blend)
			size = lerpf(targ_size, t.size, blend)
			near = lerpf(targ_range.x, t.near, blend)
			far = lerpf(targ_range.y, t.far, blend)
		, 0.0, 1.0, 0.5)\
			.set_trans(Tween.TRANS_SINE)
		_tween.tween_callback(func():
			target = t
			_next_target = null
			_tween = null)
	else:
		target = t

func _process(_delta: float) -> void:
	if not target: return
	if not _tween:
		projection = target.projection
		global_transform = target.global_transform
		h_offset = target.h_offset
		v_offset = target.v_offset
		fov = target.fov
		size = target.size
		near = target.near
		far = target.far
