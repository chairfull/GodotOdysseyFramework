class_name Controllable extends Node3D

@warning_ignore("unused_signal")
signal controlled()
@warning_ignore("unused_signal")
signal uncontrolled()

func _init() -> void:
	add_to_group(&"Controllable")

func is_controlled() -> bool:
	return get_controller() != null

func get_controller() -> Controller:
	for child in get_children():
		if child is Controller:
			return child
	return null
	#if not is_inside_tree():
		#return null
	#for controller: Controller in get_tree().get_nodes_in_group(&"Controller"):
		#if controller.controllable == self:
			#return controller
	#return null
