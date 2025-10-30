class_name Quadruped extends Agent

func set_direction(dir: float):
	super(dir)
	%collider.rotation.y = dir
