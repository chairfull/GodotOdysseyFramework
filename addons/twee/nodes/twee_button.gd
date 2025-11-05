@tool
class_name TweeButton extends TweeNode
## Meant to be a child of the TweeButtonList

signal other_chosen() ## Different node was chosen. Meant for a fade out.
signal chosen() ## I was chosen. Meant for a fade out.
signal hovered()
signal unhovered()
signal focused()
signal unfocused()

func _init() -> void:
	if not Engine.is_editor_hint():
		if (self as Object) is Control:
			var con: Control = (self as Object)
			con.mouse_entered.connect(_hovered)
			con.mouse_exited.connect(_unhovered)
			con.focus_entered.connect(_focused)
			con.focus_exited.connect(_unfocused)

func _hovered():
	if (self as Object) is Button:
		if not (self as Object as Button).disabled: hovered.emit()

func _unhovered():
	if (self as Object) is Button:
		if not (self as Object as Button).disabled: unhovered.emit()

func _focused():
	if (self as Object) is Button:
		if not (self as Object as Button).disabled: focused.emit()

func _unfocused():
	if (self as Object) is Button:
		if not (self as Object as Button).disabled: unfocused.emit()

func _get_configuration_warnings() -> PackedStringArray:
	var parent := get_parent()
	if parent and not parent is TweeButtonList:
		return ["TweeButton meant to be child of TweeButtonList."]
	return []
