class_name MarkerControl extends Control

signal entered_view()
signal exited_view()

@export var text: String: set=set_text, get=get_text
var _in_view := false

func set_text(t: String) -> void:
	if is_inside_tree(): %text.text = t

func get_text() -> String:
	return %text.text

func is_in_view() -> bool:
	return _in_view

func enter_view() -> void:
	_in_view = true
	entered_view.emit()

func exit_view() -> void:
	_in_view = false
	exited_view.emit()
