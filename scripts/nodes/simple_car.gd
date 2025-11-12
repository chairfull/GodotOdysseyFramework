extends Vehicle

@export_group("Speed")
@export var max_speed := 50.0
@export var acceleration := 120.0
var vehicle_linear_velocity := 0.0

@export_group("Steering & Brake")
@export var steering_speed := 1.5
@export var max_steering_angle := 0.65
@export var brake_force := 5.0

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

func _physics_process(delta: float) -> void:
	# Steering.
	var vehicle: VehicleBody3D = self as Object as VehicleBody3D
	vehicle.steering = move_toward(vehicle.steering, -move.x * max_steering_angle, delta * steering_speed)
	
	# Engine force.
	vehicle_linear_velocity = vehicle.linear_velocity.length()
	var speed_factor := 1.0 - minf(vehicle_linear_velocity / max_speed, 1.0)
	vehicle.engine_force = -move.y * acceleration * speed_factor
	
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
	if _braking:
		vehicle.brake = lerpf(vehicle.brake, brake_force, delta * 5.0)
		for light in brake_lights:
			light.visible = true
	else:
		vehicle.brake = 0.0
		for light in brake_lights:
			light.visible = false
	
	var engine_rev_idle := 0.9
	var engine_rev_max := 1.5
	if move.y > 0.5 or move.y < -0.5:
		engine_rev += 3.0 * delta
		if engine_rev > engine_rev_max:
			engine_rev = engine_rev_max
	else:
		engine_rev -= 5.0 * delta
		if engine_rev < engine_rev_idle:
			engine_rev = engine_rev_idle
	
	aux_engine.pitch_scale = engine_rev

func honk():
	%aux_horn.play()

func _process(_delta: float) -> void:
	for wheel in wheels:
		wheel.wheel_friction_slip = wheel_friction
		wheel.suspension_stiffness = suspension_stiff_value

func _controlled(con: Controller) -> void:
	super(con)
	if not aux_engine.playing:
		aux_engine.play()
	
	for light in front_lights:
		light.visible = true

func _uncontrolled(con: Controller) -> void:
	super(con)
	
	if aux_engine.playing:
		aux_engine.stop()
	
	for light in front_lights:
		light.visible = false
