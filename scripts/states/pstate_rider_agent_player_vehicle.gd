class_name PStateRiderAgentPlayerVehicle extends PStateRiderAgentPlayer

var vehicle: Vehicle:
	get: return pawn.node

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()
	
	elif is_action_both(&"honk", vehicle.honk_start, vehicle.honk_stop): pass
	elif is_action_both(&"brake", vehicle.brake_start, vehicle.brake_stop): pass

func _physics_process(_delta: float) -> void:
	var move := get_player_controller().get_move_vector()
	vehicle.move = move

func _disable() -> void:
	super()
	
	vehicle.move = Vector2.ZERO
	vehicle.brake = false
