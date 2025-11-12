class_name ControllableMountable extends Controllable

var rider: Pawn

func _ready() -> void:
	super()
	if pawn:
		pawn.mounted.connect(_mounted)
		pawn.unmounted.connect(_unmounted)
	
func _mounted(r: Pawn) -> void:
	rider = r

func _unmounted(_r: Pawn) -> void:
	rider = null
