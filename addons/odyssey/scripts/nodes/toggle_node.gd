@tool extends Node

@export var interactive: Interactive: set=set_interactive
@export var on := true:
	get: return interactive.toggle_state == on_state if interactive else false
	set(o):
		if on_state == 0:
			on_state = 1
		else:
			on_state = 0
@export var on_state := 0:
	set(s):
		on_state = s
		_toggled()
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_on := ""
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_off := ""

func set_interactive(inter: Interactive):
	if interactive:
		interactive.toggled.disconnect(_toggled)
	if inter == null:
		var parent := get_parent()
		if parent is Interactive:
			inter = parent
	interactive = inter
	if interactive:
		interactive.toggled.connect(_toggled)

func _toggled():
	if on:
		_execute_script(expr_on)
	else:
		_execute_script(expr_off)

func _execute_script(expr: String):
	if not is_inside_tree(): return
	var gd := GDScript.new()
	gd.source_code = "@tool\nstatic var this\nstatic func _run(): %s" % [expr.replace("$", "this.")]
	var err := gd.reload()
	if err != OK:
		push_error(self, error_string(err))
		return
	gd.this = self
	gd._run()
