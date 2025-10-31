@tool
class_name Mount extends Controllable
## Controllable that takes another controllable as it's child.
## When unmounted, returns control to the mounter.

@export var interactive: Interactive:
	get: return interactives[0] if interactives.size() > 0 else null
	set(inter):
		if interactives.size() == 0:
			interactives.append(inter)
		else:
			interactives[0] = inter
@export var interactives: Array[Interactive]
@export var siblings: Array[Mount]
@export var mounted_controllable: Controllable
@export var state_script: GDScript
var _state_node: Node

func _ready() -> void:
	for inter in interactives:
		inter.interacted.connect(_interacted)
	if mounted_controllable:
		mount(mounted_controllable)

func _interacted(con: Controllable, _form: Interactive.Form):
	if is_mounted():
		unmount()
	mount(con)

func mount(con: Controllable):
	mounted_controllable = con
	# Handoff control.
	if mounted_controllable.is_controlled():
		mounted_controllable.controller.set_controllable(self)

func unmount():
	if not mounted_controllable: return
	# Handoff control.
	if is_controlled():
		controller.set_controllable(mounted_controllable) 
	
	mounted_controllable = null

func is_mounted() -> bool:
	return mounted_controllable != null

func is_mountable(con: Controllable) -> bool:
	return con != null

func _control_started(con: Controller):
	super(con)
	print("CONTROL ", name)
	if is_player_controlled():
		_state_node = state_script.new()
		_state_node.mount = self
		_state_node.name = state_script.resource_path.get_basename().get_file()
		add_child(_state_node)

func _control_ended(con: Controller):
	super(con)
	print("UNCONTROL ", name)
	if _state_node:
		remove_child(_state_node)
		_state_node.queue_free()
