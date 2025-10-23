extends Vehicle

@onready var door_driver: Interactive = %door_driver
@onready var seat_driver: Holder = %seat_driver
var state: VehicleState

func _ready() -> void:
	door_driver.can_interact = func(c: Controllable):
		if not seat_driver.is_holding():
			return true
		return c is Humanoid
	
	door_driver.interacted.connect(func(c: Controllable):
		seat_driver.controllable = c
		)
	
	seat_driver.held.connect(_occupied)
	seat_driver.unheld.connect(_unoccupied)

func _occupied():
	state = load("res://scripts/states/vehicle_state_occupied.gd").new()
	state.vehicle = self
	add_child(state)

func _unoccupied():
	remove_child(state)
	state.queue_free()
	state = null
