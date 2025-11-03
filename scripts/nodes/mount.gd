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
@export var parent_to_self := true ## Parent the controllable to the mount.
@export var hud_scene: PackedScene ## If player, scene added to hud.
@export var cinematic: PackedScene ## Cinematic to play.
var _last_parent: Node

func _ready() -> void:
	for inter in interactives:
		inter.interacted.connect(_interacted)
	set_mount_state_enabled(false)
	if mounted_controllable:
		mount(mounted_controllable)

func _interacted(con: Controllable, _form: Interactive.Form):
	if is_mounted():
		unmount()
	mount(con)

func mount(con: Controllable):
	mounted_controllable = con
	
	if parent_to_self:
		_last_parent = con.get_parent()
		con.reparent(self)
	
	# Handoff control.
	if mounted_controllable.is_controlled():
		mounted_controllable.controller.set_controllable(self)

func unmount():
	if not mounted_controllable: return
	# Handoff control.
	if is_controlled():
		controller.set_controllable(mounted_controllable) 
	
	if _last_parent:
		mounted_controllable.reparent(_last_parent)
	
	mounted_controllable = null
	_last_parent = null
	
func is_mounted() -> bool:
	return mounted_controllable != null

func is_mountable(con: Controllable) -> bool:
	return con != null

func _control_started(con: Controller):
	super(con)
	set_mount_state_enabled(true)

func _control_ended(con: Controller):
	super(con)
	set_mount_state_enabled(false)

func set_mount_state_enabled(enabled := true) -> void:
	for node in get_children():
		if node is MountState:
			if enabled:
				node._enable()
			else:
				node._disable()

func _get_configuration_warnings() -> PackedStringArray:
	var out: PackedStringArray
	var has_mount_state := false
	for child in get_children():
		if child is MountState:
			has_mount_state = true
			break
	if not has_mount_state:
		out.append("Requires a MountState child.")
	return out
