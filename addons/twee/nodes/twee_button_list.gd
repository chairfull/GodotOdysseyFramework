@tool
class_name TweeButtonList extends TweeNode

signal selected(node: Node)

@export var disable_on_pressed := false
@export var focus_on_hovered := true
@export var focus_highlight: Control
var hovered := -1: set=set_hovered
var buttons: Array[TweeButton]

func _init() -> void:
	if not Engine.is_editor_hint():
		child_entered_tree.connect(_child_entered)
		child_exiting_tree.connect(_child_exited)

func clear():
	for i in range(buttons.size()-1, -1, -1):
		var btn := buttons[i]
		remove_child(btn)
		btn.queue_free()
	buttons.clear()
	hovered = -1

func select() -> bool:
	if hovered != -1:
		_pressed(buttons[hovered])
		return true
	return false

func hover_next(dir: int) -> void:
	var next := hovered + dir
	if next >= buttons.size(): next = 0
	if next < 0: next = buttons.size()-1
	set_hovered(next)

func set_hovered(h: int) -> void:
	var last_hovered := hovered
	hovered = h
	for i in buttons.size():
		var node := buttons[i]
		if i == hovered: node.hover()
		elif i == last_hovered: node.unhover()

func _child_entered(child: Node):
	if not child is TweeButton: return
	if not child in buttons: buttons.append(child)
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.connect(_pressed.bind(child))
		btn.focused.connect(_focused.bind(child))
		btn.unfocused.connect(_unfocused.bind(child))

func _child_exited(child: Node):
	if not child is TweeButton: return
	if child in buttons: buttons.erase(child)
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.disconnect(_pressed)

func _unfocused(node: TweeButton):
	if focus_highlight:
		focus_highlight.modulate.a = 0.1
	
func _focused(node: TweeButton):
	if focus_highlight:
		focus_highlight.global_position = node.global_position
		focus_highlight.modulate.a = 1.0

func _pressed(node: TweeButton):
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
