class_name Marker extends Node3D

enum LabelStyle { DISTANCE, TEXT, NAME }

@export var offset: Vector2
@export var color := Color.WHITE
@export var enabled := true: set=set_enabled
@export var text := ""
@export var label_style := LabelStyle.DISTANCE

func set_enabled(e: bool) -> void:
	if enabled == e: return
	enabled = e
	if enabled: Global.group_add(self, &"marker")
	else: Global.group_remove(self, &"marker")
