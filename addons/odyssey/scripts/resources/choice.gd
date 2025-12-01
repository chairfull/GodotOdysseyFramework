class_name Choice extends Resource

@export var text := "" ## Main text to show in menu.
@export var long := "" ## Longer text to show.
@export var icon := "" ## Emoji or resource path.
@export var menu: Array[StringName] ## Menus we show up in.
@export var tags: Array[StringName] ## Styles and other options.
@export var rank := 0 ## Used when sorting.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var cond := "" ## Condition that must be true.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var call := "" ## Method called on pressed.
