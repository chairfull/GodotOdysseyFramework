@tool
extends Node

@export var toggle: InteractiveToggle: set=set_toggle
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_on := ""
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_off := ""

func set_toggle(tog: InteractiveToggle):
	if toggle: toggle.toggled.disconnect(_toggled)
	toggle = tog
	if toggle: toggle.toggled.connect(_toggled)

func _toggled(on: bool):
	var exx := expr_on if on else expr_off
	var gd := GDScript.new()
	gd.source_code = "static var this\nstatic func _run(): %s" % [exx.replace("$", "this.")]
	gd.reload()
	gd.this = self
	gd._run()
