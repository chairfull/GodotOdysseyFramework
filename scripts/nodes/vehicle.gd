class_name Vehicle extends VehicleBody3D

@export var info: VehicleInfo

var _brake_pressed := false ## 
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)

func honk_start(): return true
func honk_stop(): return true

func brake_start():
	_brake_pressed = true
	return true

func brake_stop():
	_brake_pressed = false
	return true
