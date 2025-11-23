extends Node3D

@export var area: Area3D:
	get: return area if area else get_parent()

func _ready() -> void:
	area.body_entered.connect(_body_entered)
	area.body_exited.connect(_body_exited)
	area.body_shape_entered.connect(_body_shape_entered)
	area.body_shape_exited.connect(_body_shape_exited)
	
func _body_entered(body: Node3D):
	pass

func _body_exited(body: Node3D):
	pass

func _body_shape_entered(b):
	pass

func _body_shape_exited(b):
	pass
