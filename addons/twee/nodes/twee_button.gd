@tool
class_name TweeButton extends TweeNode
## Meant to be a child of the TweeButtonList

signal other_chosen() ## Different node was chosen. Meant for a fade out.
signal chosen() ## I was chosen. Meant for a fade out.
signal hovered()
signal unhovered()
signal focused()
signal unfocused()

@export var mouse_hoverable := true: set=set_mouse_hoverable
var button_list: TweeButtonList:
	get: return get_parent()
var index: int:
	get: return button_list.buttons.find(self)

func _init() -> void:
	if not Engine.is_editor_hint():
		if is_control():
			var con := as_control()
			con.focus_entered.connect(focus)
			con.focus_exited.connect(unfocus)

func set_mouse_hoverable(h: bool):
	mouse_hoverable = h
	var con := as_control()
	if mouse_hoverable:
		con.mouse_entered.connect(hover)
		con.mouse_exited.connect(unhover)
	else:
		con.mouse_entered.disconnect(hover)
		con.mouse_exited.disconnect(unhover)

func is_button() -> bool: return (self as Object) is Button
func as_button() -> Button: return (self as Object) as Button

func hover():
	if is_button():
		if not as_button().disabled:
			button_list.hovered = index
			hovered.emit()

func unhover():
	if is_button():
		if not as_button().disabled:
			button_list.hovered = -1
			unhovered.emit()

func focus():
	if is_button():
		if not as_button().disabled: focused.emit()

func unfocus():
	if is_button():
		if not as_button().disabled: unfocused.emit()

func _get_configuration_warnings() -> PackedStringArray:
	var parent := get_parent()
	if parent and not parent is TweeButtonList:
		return ["TweeButton meant to be child of TweeButtonList."]
	return []
