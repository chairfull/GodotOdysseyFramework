@tool
extends Node3D

@export var left_limit: SkeletonFootLimit
@export var right_limit: SkeletonFootLimit

#func _process(delta: float) -> void:
	#var mid := (left_limit.hit_position + right_limit.hit_position) * .5
	##print(mid)
	##position.y = 0.0
	#position.y = lerpf(position.y , mid.y, 0.5)
