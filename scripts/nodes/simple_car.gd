extends Vehicle

@onready var door_driver: Interactive = %door_driver
@onready var seat_driver: Mount = %seat_driver
var state: VehicleState

var throttle := 0.0
var steering_input := 0.0
@export_group("Speed")
@export var max_speed := 50.0
@export var acceleration := 120.0
var vehicle_linear_velocity := 0.0

@export_group("Steering & Brake")
@export var steering_speed := 1.5
@export var max_steering_angle := 0.65
@export var handbrake_force := 5.0
var handbrake := false

@export_group("Lights")
@onready var light_front_driver: SpotLight3D = %light_front_driver
@onready var light_front_passenger: SpotLight3D = %light_front_passenger
@onready var light_brake_driver: OmniLight3D = %light_brake_driver
@onready var light_brake_passenger: OmniLight3D = %light_brake_passenger
@onready var front_lights: Array[SpotLight3D] = [light_front_driver, light_front_passenger]
@onready var brake_lights: Array[OmniLight3D] = [light_brake_driver, light_brake_passenger]

@export_group("Wheels")
@onready var wheel_front_driver: VehicleWheel3D = %wheel_front_driver
@onready var wheel_front_passenger: VehicleWheel3D = %wheel_front_passenger
@onready var wheel_back_driver: VehicleWheel3D = %wheel_back_driver
@onready var wheel_back_passenger: VehicleWheel3D = %wheel_back_passenger
@onready var wheels: Array[VehicleWheel3D] = [wheel_front_driver, wheel_front_passenger, wheel_back_driver, wheel_back_passenger]

@export_group("Suspension Setting")
@export var wheel_friction := 10.5
@export var suspension_stiff_value := 0.0

@export_group("Stability Control")
@export var roll_influence := 0.5
var anti_roll_torque: Vector3
var downforce: Vector3
@export var anti_roll_force := 20.0
@export var downforce_factor := 50.0

@export_group("Audio")
@onready var aux_engine: AudioStreamPlayer3D = %aux_engine
var engine_rev := 0.0

#func _ready() -> void:
	#door_driver.can_interact = func(c: Controllable):
		#if not seat_driver.is_mounted():
			#return true
		#return c is Humanoid
	#
	#door_driver.interacted.connect(func(c: Controllable):
		#seat_driver.controllable = c
		#)
	#
	#seat_driver.held.connect(_occupied)
	#seat_driver.unheld.connect(_unoccupied)

func _physics_process(delta: float) -> void:
	throttle = Input.get_axis(&"move_forward", &"move_backward")
	steering_input = Input.get_axis(&"move_left", &"move_right")
	handbrake = Input.is_action_pressed(&"brake")
	
	# Steering.
	var vehicle: VehicleBody3D = convert(self, TYPE_OBJECT)
	vehicle.steering = move_toward(vehicle.steering, -steering_input * max_steering_angle, delta * steering_speed)
	
	# Engine force.
	vehicle_linear_velocity = vehicle.linear_velocity.length()
	var speed_factor := 1.0 - minf(vehicle_linear_velocity / max_speed, 1.0)
	vehicle.engine_force = throttle * acceleration * speed_factor
	
	# Anti-Roll
	anti_roll_torque = -global_transform.basis.z * global_rotation.z * anti_roll_force * max_speed
	vehicle.apply_torque(anti_roll_torque)
	
	# Speed based downforce
	downforce = -global_transform.basis.y * vehicle_linear_velocity * downforce_factor
	vehicle.apply_central_force(downforce)
	
	# Apply to all wheels.
	for wheel in wheels:
		wheel.wheel_roll_influence = roll_influence
	
	# Handbrake.
	if handbrake:
		vehicle.brake = handbrake_force
		for light in brake_lights:
			light.visible = true
	else:
		vehicle.brake = 0.0
		for light in brake_lights:
			light.visible = false
	
	# Audio: Engine.
	if not aux_engine.playing:
		aux_engine.play()
	
	var engine_rev_idle := 0.9
	var engine_rev_max := 1.5
	if throttle > 0.5 or throttle < -0.5:
		engine_rev += 3.0 * delta
		if engine_rev > engine_rev_max:
			engine_rev = engine_rev_max
	else:
		engine_rev -= 5.0 * delta
		if engine_rev < engine_rev_idle:
			engine_rev = engine_rev_idle
	
	aux_engine.pitch_scale = engine_rev
	
func _process(_delta: float) -> void:
	for wheel in wheels:
		wheel.wheel_friction_slip = wheel_friction
		wheel.suspension_stiffness = suspension_stiff_value

func _occupied():
	state = load("res://scripts/states/vehicle_state_occupied.gd").new()
	state.vehicle = self
	add_child(state)

func _unoccupied():
	remove_child(state)
	state.queue_free()
	state = null
