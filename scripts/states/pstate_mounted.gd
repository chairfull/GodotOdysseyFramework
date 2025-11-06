@abstract class_name PStateMounted extends PawnState
## Enables when mounted to a Pawn.

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.mounted.connect(_mounted)
	pawn.unmounted.connect(_unmounted)

func _mounted(_mount: Pawn) -> void:
	if not _accept_controller(pawn.get_controller_recursive()): return
	_enable()

func _unmounted(_mount: Pawn) -> void:
	if not _accept_controller(pawn.get_controller_recursive()): return
	if not _enabled: return
	_disable()
