class_name Marker extends Node3D

@export var screen_pos: Vector2

#func _ready() -> void:
	#visibility_changed.connect(func(): (Controllers.EV_SHOW_MARKER if visible else Controllers.EV_HIDE_MARKER).emit(self))
	#tree_entered.connect(Controllers.EV_SHOW_MARKER.emit.bind(self))
	#tree_exited.connect(Controllers.EV_HIDE_MARKER.emit.bind(self))
	#Controllers.EV_SHOW_MARKER.fire.call_deferred(self)
