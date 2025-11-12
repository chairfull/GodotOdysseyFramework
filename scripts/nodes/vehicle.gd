class_name Vehicle extends VehicleBody3D

@export var info: VehicleInfo
@export var pawn: Pawn
var _brake_pressed := false ## 
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)

func _ready() -> void:
	pawn.posessed.connect(_posessed)
	pawn.unposessed.connect(_unposessed)
	pawn.rider_mounted.connect(_mounted)
	pawn.rider_unmounted.connect(_unmounted)
	set_process_unhandled_input(false)

func _posessed(_con: Controller) -> void:
	set_process_unhandled_input(true)

func _unposessed(_con: Controller) -> void:
	set_process_unhandled_input(false)

func _mounted(_rider: Pawn) -> void:
	pass

func _unmounted(_rider: Pawn) -> void:
	move = Vector2.ZERO
	brake = false

func honk_start(): return true
func honk_stop(): return true

func brake_start():
	_brake_pressed = true
	return true

func brake_stop():
	_brake_pressed = false
	return true

## Used when Controller active.
func _unhandled_input(event: InputEvent) -> void:
	pawn.controller._event = event
	
	if pawn.is_action_pressed(&"exit"):
		pawn.kick_rider()
		pawn.handle_input()
	
	elif pawn.is_action_both(&"honk", honk_start, honk_stop): pass
	elif pawn.is_action_both(&"brake", brake_start, brake_stop): pass

func _physics_process(_delta: float) -> void:
	move = pawn.controller.get_move_vector()
