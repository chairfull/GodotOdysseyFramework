extends Widget

@onready var button_parent: VBoxContainer = %button_parent
@onready var button_prefab: Button = %button_prefab
@onready var blur: ColorRect = %blur
@onready var panel: PanelContainer = %panel

var options: Array[Dictionary]
var hovered: Node
var buttons: Array[Button]

func _ready() -> void:
	button_parent.remove_child(button_prefab)
	
	blur.modulate.a = 0.0
	_tween = create_tween()
	_tween.tween_property(blur, "modulate:a", 1.0, 0.2)
	
	if hovered:
		var vpsize := Global.view_size
		if hovered is Control:
			var rect := (hovered as Control).get_global_rect()
			ShadMat.new(blur, {
				start=rect.position / vpsize,
				end=rect.end / vpsize
			})
		else:
			ShadMat.new(blur, { start=Vector2.ONE, end=Vector2.ONE })
	
	var index := 0
	for op in options:
		var btn := button_prefab.duplicate()
		button_parent.add_child(btn)
		btn.text = op.get("text", "NO_TEXT")
		btn.pressed.connect(_pressed_option.bind(index))
		index += 1
	
	panel.position = get_viewport().get_mouse_position()

func is_pauser() -> bool:
	return true

func _pressed():
	for button in buttons:
		button.disabled = true
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(blur, "modulate:a", 0.0, 0.1)
	#_tween.tween_callback(close)

func _pressed_option(index: int):
	_pressed()
	var op := options[index]
	op.call.call()
