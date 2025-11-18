extends Widget

@export var text: String:
	get: return %label.text
	set(t):
		text = t
		%label.text = t

@export var accept_text: String:
	get: return %accept.text
	set(t):
		accept_text = t
		%acept.text = t
	
@export var cancel_text: String:
	get: return %cancel.text
	set(t):
		cancel_text = t
		%cancel.text = t
