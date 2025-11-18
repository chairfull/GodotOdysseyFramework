class_name Quadruped extends CharNode

func set_direction(dir: float):
	super(dir)
	%collider.rotation.y = dir
