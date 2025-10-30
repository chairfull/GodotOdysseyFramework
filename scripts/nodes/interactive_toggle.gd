@tool class_name InteractiveToggle extends Interactive

signal toggled(on: bool)

@export var on := true: set=set_on
@export var label_on := "Disable"
@export var label_off := "Enable"

func _interacted(controllable: Controllable, form: Form) -> void:
	super(controllable, form)
	set_on(not on)

func set_on(o: bool):
	on = o
	toggled.emit(on)
	label = label_on if on else label_off
