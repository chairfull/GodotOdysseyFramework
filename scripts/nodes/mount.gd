class_name Mount extends Node3D
## Object that can handle multiple Pawns.

@export var interactive: Interactive
@export var max_occupants := 1_000
var _occupants: Array[Pawn]

func _ready() -> void:
	interactive.can_interact = _can_interact
	interactive.interacted.connect(_interacted)

func _interacted(pawn: Pawn, _form: Interactive.Form):
	_occupants.append(pawn)
	
	var mount := Pawn.new()
	mount.name = pawn.name + "_mount"
	add_child(mount)
	mount.set_rider.call_deferred(pawn)

func _can_interact(_pawn: Pawn) -> bool:
	return _occupants.size() < max_occupants
