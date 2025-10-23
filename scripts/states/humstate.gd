class_name HumanoidState extends Node

var humanoid: Humanoid

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"toggle_first_person"):
		humanoid.view_state = Humanoid.ViewState.FirstPerson
	if Input.is_action_just_pressed(&"toggle_third_person"):
		humanoid.view_state = Humanoid.ViewState.ThirdPerson
	if Input.is_action_just_pressed(&"toggle_top_down"):
		humanoid.view_state = Humanoid.ViewState.TopDown
	
