class_name Vehicle extends ControllableMountable

@export var info: VehicleInfo
var body: VehicleBody3D = self as Object as VehicleBody3D
var _braking := false ## 
var _honking := false
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)

## Used when Controller active.
func _on_controller_input(_event: InputEvent) -> void:
	if pawn.is_action_pressed(&"exit"):
		pawn.kick_rider()
		pawn.handle_input()
	
	elif pawn.is_action_both(&"honk", honk_start, honk_stop): pass
	elif pawn.is_action_both(&"brake", brake_start, brake_stop): pass

func _on_controller_update(_delta: float) -> void:
	move = pawn.controller.get_move_vector()

func _unmounted(_rider: Pawn) -> void:
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
