class_name Overrides

static var version := "v0.0.0"

static var main_menu_title: String
static var main_menu_subtitle: String
static var main_menu_options: Array[Dictionary] = [
	{ id="start", text="Start", pressed=func(): Global.change_scene("res://scenes/worlds/test_world.tscn") },
	{ id="continue", text="Continue" },
	{ id="load", text="Load" },
	{ id="settings", text="Settings" },
	{ id="quit", text="Quit", pressed=func(): Global.get_tree().quit() },
]
