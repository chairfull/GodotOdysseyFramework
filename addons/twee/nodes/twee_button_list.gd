@tool
class_name TweeButtonList extends TweeNode

signal selected(node: Node)

@export var disable_on_pressed := false
@export var focus_on_hovered := true
@export var focus_highlight: Control

func _init() -> void:
	if not Engine.is_editor_hint():
		remove_child(focus_highlight)
		child_entered_tree.connect(_child_entered)
		child_exiting_tree.connect(_child_exited)

func _child_entered(child: Node):
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.connect(_pressed.bind(child))
		btn.focused.connect(_focused.bind(child))
		btn.unfocused.connect(_unfocused.bind(child))

func _child_exited(child: Control):
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.disconnect(_pressed)

func _unfocused(node: Control):
	focus_highlight.modulate.a = 0.1
	
func _focused(node: Control):
	focus_highlight.global_position = node.global_position
	focus_highlight.modulate.a = 1.0

func _pressed(node: Control):
	for child in get_children():
		if child is TweeButton:
			if child == node:
				child.chosen.emit()
			else:
				child.other_chosen.emit()
		
		if disable_on_pressed and child is Button:
			(child as Button).disabled = true
	
	selected.emit(node)

func disable(...args):
	for child in get_children():
		if child is Button:
			child.text = str(args)
			child.disabled = true

func quit():
	get_tree().quit()
