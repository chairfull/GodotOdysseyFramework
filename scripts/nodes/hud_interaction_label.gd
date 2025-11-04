extends Control

@onready var label: RichTextLabel = %label
@export var interactive: Interactive: set=set_interactive

func _ready() -> void:
	visible = false
	set_process(false)

func set_interactive(inter: Interactive):
	if inter:
		set_process(true)
		label.text = inter.label
		modulate.a = 0.0
		visible = true
		interactive = inter
		UTween.parallel(self, { "modulate:a": 1.0 }, 0.2)
	else:
		UTween.parallel(self, { "modulate:a": 0.0 }, 0.2)\
			.finished.connect(func():
				visible = false
				interactive = null
				set_process(false))

func _process(_delta: float) -> void:
	if not interactive: return
	var vp := Controllers.player.viewport
	var cam := vp.get_camera_3d()
	var pos_3d := interactive.global_position + interactive.label_world_space_offset
	var pos := cam.unproject_position(pos_3d)
	pos -= size * .5
	pos.x = clampf(pos.x, 0.0, vp.size.x)
	pos.y = clampf(pos.y, 0.0, vp.size.y)
	position = pos
	
