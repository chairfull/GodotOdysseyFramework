class_name CameraMaster extends Camera3D

@export var target: Camera3D: set=set_target
var _remote: RemoteTransform3D
var _remote2: RemoteTransform3D

func set_target(t: Camera3D):
	print("Set target ", t)
	if target == t: return
	if _remote:
		_remote.get_parent().remove_child(_remote)
		_remote.queue_free()
		_remote = null
		
		_remote2.get_parent().remove_child(_remote2)
		_remote2.queue_free()
		_remote2 = null
		
	target = t
	if target:
		_remote = RemoteTransform3D.new()
		target.add_child(_remote)
		_remote.name = "main_camera"
		_remote.update_scale = false
		_remote.remote_path = get_path()
		
		_remote2 = RemoteTransform3D.new()
		target.add_child(_remote2)
		_remote2.name = "fps_camera"
		_remote2.update_scale = false
		_remote2.remote_path = %fps_camera_master.get_path()
		
		var targ_offset := Vector2(target.h_offset, target.v_offset)
		var targ_fov := target.fov
		var targ_size := target.size
		var targ_range := Vector2(target.near, target.far)
		UTween.interp(self, func(blend: float):
			h_offset = lerpf(targ_offset.x, t.h_offset, blend)
			v_offset = lerpf(targ_offset.y, t.v_offset, blend)
			fov = lerpf(targ_fov, t.fov, blend)
			size = lerpf(targ_size, t.size, blend)
			near = lerpf(targ_range.x, t.near, blend)
			far = lerpf(targ_range.y, t.far, blend)
		, 0.5)
