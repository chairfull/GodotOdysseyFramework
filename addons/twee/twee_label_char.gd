class_name TweeLabelChar extends Resource

@export var seed := 123
@export var text := "?"
@export var index := 0
@export var trans := Transform2D.IDENTITY
@export var rect := Rect2()
var origin: Vector2:
	get: return trans.get_origin()
	set(o): trans.origin = o

@export var off := Vector2.ZERO: set=set_off
var offx: float:
	get: return off.x
	set(o): off.x = o
var offy: float:
	get: return off.y
	set(o): off.y = o

@export var color: Color = Color.WHITE
var r: float:
	get: return color.r
	set(f): color.r = f
var g: float:
	get: return color.g
	set(f): color.g = f
var b: float:
	get: return color.b
	set(f): color.b = f
var a: float:
	get: return color.a
	set(f): color.a = f
var rgb: Color:
	get: return color
	set(c):
		color.r = c.r
		color.g = c.g
		color.b = c.b

var rotation: float:
	get: return trans.get_rotation()
	set(r): trans = Transform2D(r, trans.origin)
var degrees := 0.0:
	get: return rad_to_deg(rotation)
	set(f): rotation = deg_to_rad(f)

var scale: Vector2:
	get: return trans.get_scale()
	set(s): trans *= Transform2D.IDENTITY.scaled(s)
var scalex: float:
	get: return scale.x
	set(f): scale.x = f
var scaley: float:
	get: return scale.y
	set(f): scale.y = f

var skew: float:
	get: return trans.get_skew()
	set(s): trans = Transform2D(rotation, scale, s, origin)

@export var rand: Vector2: get=get_rand
var randx: float:
	get: return rand.x
var randy: float:
	get: return rand.y

func set_off(p):
	off = p

func reset_seed() -> void:
	seed = randi()

func get_rand() -> Vector2:
	var angle := fmod(seed, TAU)
	return Vector2(cos(angle), sin(angle))
