extends Widget

var _markers: Dictionary[Marker, HUDMarker]

func _ready() -> void:
	Controllers.event.connect(_event)

func _event(event: Event, data: Variant):
	match event:
		Controllers.EV_SHOW_MARKER:
			var node: Marker = data
			if not node in _markers:
				var marker: HUDMarker = load("res://scenes/ui/marker.tscn").instantiate()
				add_child(marker)
				marker.target = node
				marker.camera = %camera_master
				marker.viewport = %viewport
				_markers[node] = marker
		
		Controllers.EV_HIDE_MARKER:
			var node: Marker = data
			if node in _markers:
				var marker: HUDMarker = _markers[node]
				_markers.erase(node)
				remove_child(marker)
