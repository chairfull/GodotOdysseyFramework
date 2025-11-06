@abstract class_name PStatePosessed extends PawnState
## Enabled when Pawn is posessed.

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.posessed.connect(_posessed)
	pawn.unposessed.connect(_unposessed)

func _posessed(con: Controller):
	if not _accept_controller(con): return
	if _enabled: return
	_controller = con
	_enable()

func _unposessed(con: Controller):
	if _enabled and _controller == con:
		_disable()
		_controller = null
