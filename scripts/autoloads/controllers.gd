extends Control
## Handles players and npcs.

#signal event(ev: Event, data: Variant)

var player: Controller = load("res://scenes/prefabs/controller_player.tscn").instantiate()
var player2: Controller = load("res://scenes/prefabs/controller_player.tscn").instantiate()
var players: Dictionary[StringName, Controller] = {
	"player": player,
	"player2": player2
}

#var EV_SHOW_MARKER := Event.new(event)
#var EV_HIDE_MARKER := Event.new(event)

func _ready() -> void:
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
	
	add_child(player)
	#for c in controllers:
		#add_child(c)
	size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	player.index = 0
	player.name = "player_1"
	player.set_size.call_deferred(size)

	player2.index = 1
	player2.name = "player_2"
	player2.set_size.call_deferred(size)
	
	_toggle_1_player()
	
	get_tree().current_scene.get_viewport().disable_3d = true

func get_controller(index: int) -> Controller:
	match index:
		0: return player
		1: return player2
	return null

func _toggle_1_player():
	player.visible = true
	player.set_size.call_deferred(size)
	player.viewport_container.size = player.size
	
	player2.visible = false
	
func _toggle_2_player():
	if not player2.get_parent():
		add_child(player2)
	
	player.visible = true
	player.size = Vector2(size.x * .5, size.y)
	player.viewport_container.size = player.size
	#RenderingServer.viewport_attach_camera(player.viewport.get_viewport_rid(), player.camera_master.get_camera_rid())
	
	player2.visible = true
	player2.size = Vector2(size.x * .5, size.y)
	player2.position.x = size.x * .5
	player2.viewport_container.size = player2.size
	#RenderingServer.viewport_attach_camera(player.viewport.get_viewport_rid(), player.camera_master.get_camera_rid())

func _unhandled_input(ev: InputEvent) -> void:
	if ev.is_action_pressed(&"toggle_1_player", false, true):
		_toggle_1_player()
		get_viewport().set_input_as_handled()
	elif ev.is_action_pressed(&"toggle_2_player", false, true):
		_toggle_2_player()
		get_viewport().set_input_as_handled()
