@abstract class_name MarkersWidget extends Widget
## Base class used by Compass Marker and HUD Marker.

@onready var camera := get_controller().camera_master
var markers: Dictionary[Node3D, MarkerControl]

func _ready() -> void:
	for node in get_tree().get_nodes_in_group(&"marker"):
		_group_added(node, &"marker")
	Global.added_to_group.connect(_group_added)
	Global.added_to_group.connect(_group_removed)

## Asset to use as a marker.
func get_marker_asset() -> StringName:
	return &""

func _group_added(node: Node, id: StringName) -> void:
	if id != &"marker": return
	if node.owner == get_controller().pawn: return
	var marker := Assets.create_scene(get_marker_asset(), self)
	markers[node as Node3D] = marker

func _group_removed(node: Node, id: StringName) -> void:
	if id != &"marker": return
	if node.owner == get_controller().pawn: return
	var marker := markers[node as Node3D]
	remove_child(marker)
	marker.queue_free()
	markers.erase(node)
