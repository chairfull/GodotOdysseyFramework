extends Agent

@export var speed := 1.5
@export var flee := false

func _ready() -> void:
	super()
	node_seeing.started.connect(_noticed)
	node_seeing.ended.connect(_unnoticed)

func _noticed():
	if not flee:
		flee = true
		#print("fly away")
	
func _unnoticed():
	if not node_seeing.is_detecting() and not node_hearing.is_detecting():
		flee = false
		#print("stop flying")

func move(to: Vector3, _delta: float) -> bool:
	var dir := Vector3(
		to.x - global_position.x,
		0.0,
		to.z - global_position.z
	)
	if dir.length() > 0.1:
		body.velocity += dir.normalized() * minf(dir.length(), speed)
		return true
	else:
		body.velocity.x = 0.0
		body.velocity.z = 0.0
		return false

func _physics_process(delta: float) -> void:
	if flee:
		if global_position.y < 3.0:
			body.velocity.y += speed * delta
		else:
			flee = false
	elif body.is_on_floor():
		body.velocity.y = 0.0
	else:
		body.velocity += body.get_gravity() * delta
	body.move_and_slide()
