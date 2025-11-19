@tool
@icon("res://addons/odyssey/icons/damageable.svg")
class_name Damageable extends Area3D

signal died()
signal damaged(amnt: float)
signal healed(amnt: float)
signal revived()

@export var max_health := 100.0
@export var health := 100.0:
	set(h): health = clampf(h, 0.0, max_health)

func _init() -> void:
	monitoring = false
	collision_layer = 1 << 10
	collision_mask = 0

func damage(amount: float, _type := -1):
	var old_health := health
	health -= amount
	if health == old_health: return
	var diff := old_health - health
	if diff > 0:
		damaged.emit(diff)
	if health == 0:
		died.emit()

func heal(amount: float, _type := -1):
	var old_health := health
	health += amount
	if health == old_health: return
	var diff := health - old_health
	if diff > 0:
		healed.emit(diff)
	if old_health == 0:
		revived.emit()
	
	
	
