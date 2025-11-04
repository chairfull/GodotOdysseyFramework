extends PawnState

var vehicle: Vehicle:
	get: return pawn

func _physics_process(_delta: float) -> void:
	var move := get_player_controller().get_move_vector()
	vehicle.move = move
	vehicle.brake = Input.is_action_pressed(&"brake")
