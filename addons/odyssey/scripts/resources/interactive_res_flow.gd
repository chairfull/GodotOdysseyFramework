class_name InteractiveResFlow extends InteractiveRes

@export var flow: FlowScript

@export var delay := 0.0

func _interact(_inter: Interactive) -> void:
	if form == _inter._interacting_form:
		if delay:
			Global.wait(delay, Cinema.queue.bind(flow))
		else:
			Cinema.queue(flow)
