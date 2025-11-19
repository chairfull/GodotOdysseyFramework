class_name CameraMaster extends Camera3D

var _target: CameraTarget
var _remote: RemoteTransform3D
var _remote2: RemoteTransform3D

func set_target(t: CameraTarget, duration := 0.0, trans := Tween.TRANS_SINE, ease := Tween.EASE_IN_OUT) -> void:
	if _target == t: return
	
	if _remote:
		_remote.get_parent().remove_child(_remote)
		_remote.queue_free()
		_remote = null
		
		_remote2.get_parent().remove_child(_remote2)
		_remote2.queue_free()
		_remote2 = null
	
	_target = t
	
	if _target:
		_set_target.call_deferred(duration, trans, ease)

func _set_target(duration: float, trans: int, ease: int) -> void:
	var cam_targ := _target.camera
	
	
	_remote2 = RemoteTransform3D.new()
	cam_targ.add_child(_remote2)
	_remote2.name = "fps_camera"
	_remote2.update_scale = false
	_remote2.remote_path = %fps_camera_master.get_path()
	
	if duration != 0.0:
		_remote = RemoteTransform3DTweened.new()
		cam_targ.add_child(_remote)
		_remote.tween_duration = duration
		_remote.tween_trans = trans
		_remote.tween_ease = ease
		_remote.name = "main_camera"
		_remote.update_scale = false
		_remote.set_node(self)
	else:
		_remote = RemoteTransform3D.new()
		cam_targ.add_child(_remote)
		_remote.name = "main_camera"
		_remote.update_scale = false
		_remote.remote_path = get_path()
		#var targ_offset := Vector2(cam_targ.h_offset, cam_targ.v_offset)
		#var targ_fov := cam_targ.fov
		#var targ_size := cam_targ.size
		#var targ_range := Vector2(cam_targ.near, cam_targ.far)
		#var pos_start := global_position
		#var rot_start := global_rotation
		#UTween.interp(self, func(blend: float):
			#_remote.global_position = pos_start.lerp(cam_targ.global_position, blend)
			#_remote.global_rotation = UVec.lerp_rotation(cam_targ.global_rotation, Vector3.ZERO, blend)
			#h_offset = lerpf(targ_offset.x, cam_targ.h_offset, blend)
			#v_offset = lerpf(targ_offset.y, cam_targ.v_offset, blend)
			#fov = lerpf(targ_fov, cam_targ.fov, blend)
			#size = lerpf(targ_size, cam_targ.size, blend)
			#near = lerpf(targ_range.x, cam_targ.near, blend)
			#far = lerpf(targ_range.y, cam_targ.far, blend)
		#, duration)
