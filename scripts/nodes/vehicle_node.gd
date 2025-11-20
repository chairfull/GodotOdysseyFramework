class_name VehicleNode extends Pawn

@export var id: StringName
@export var info: VehicleInfo:
	get: return info if info else State.vehicles.find(id)
var body: VehicleBody3D = self as Object as VehicleBody3D
var _braking := false ## 
var _honking := false
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)

## Used when Controller active.
func _update_as_player(_delta: float) -> void:
	if is_action_pressed(&"exit"):
		dismount_rider()
		handle_input()
	
	elif is_action_both(&"honk", honk_start, honk_stop): pass
	elif is_action_both(&"brake", brake_start, brake_stop): pass
	
	move = _controller.get_move_vector()

func _lost_rider() -> void:
	super()
	move = Vector2.ZERO
	body.brake = false

func honk_start():
	_honking = true
	return true

func honk_stop():
	_honking = false
	return true

func brake_start():
	_braking = true
	return true

func brake_stop():
	_braking = false
	return true
