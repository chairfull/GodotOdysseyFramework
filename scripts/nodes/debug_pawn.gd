extends Node

@onready var pawn: Pawn = get_parent()
@export var enabled := true:
	set(e):
		enabled = e
		set_process(e)

func _ready() -> void:
	set_process(enabled)

func _process(_delta: float) -> void:
	DebugDraw3D.draw_text(pawn.global_position + Vector3.UP * 2.0,
		"Rider: %s\nController: %s\nRiding: %s" % [pawn._rider, pawn._controller, pawn._riding])
