@tool
extends Node

@export var interactive: Interactive: set=set_interactive
@export var on := false
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_on := ""
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_off := ""

func set_interactive(inter: InteractiveToggle):
	if interactive: interactive.interacted.disconnect(_toggled)
	interactive = inter
	if interactive: interactive.interacted.connect(_toggled)

func _toggled(_cont: Controllable, _form: Interactive.Form):
	var exx := expr_on if on else expr_off
	var gd := GDScript.new()
	gd.source_code = "static var this\nstatic func _run(): %s" % [exx.replace("$", "this.")]
	gd.reload()
	gd.this = self
	gd._run()
