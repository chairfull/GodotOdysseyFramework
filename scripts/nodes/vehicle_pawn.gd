@tool
class_name VehiclePawn extends Pawn

var control_type := Controller.ControlType.NONE

var vehicle: Vehicle:
	get: return get_parent()

var info: VehicleInfo:
	get: return vehicle.info

#func _ready() -> void:
	#pos

func _posessed(con: Controller) -> void:
	super(con)
	control_type = con.get_control_type()
	set_process(true)
	if con.is_player():
		set_process_unhandled_input(true)

func _unposessed() -> void:
	super()
	control_type = Controller.ControlType.NONE
	set_process(false)
	set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	pass
