extends Control

@export var file: OSFile
@export var changed := false: set=set_changed

var app_visual: OSAppVisual:
	get: return owner

func _ready() -> void:
	%edit.text_changed.connect(set_changed.bind(false))

func set_changed(c: bool) -> void:
	changed = c
	if changed:
		app_visual.title = "*" + file.path.get_file()
	else:
		app_visual.title = file.path.get_file()
		
