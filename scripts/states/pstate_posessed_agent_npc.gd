@icon("res://addons/odyssey/icons/control_npc.svg")
class_name PStatePosessedAgentNPC extends PStatePosessed

var agent: Agent:
	get: return pawn.node

var _dest_point: Vector3
var _dest_inter: Interactive

func _accept_controller(con: Controller) -> bool:
	return con is ControllerNPC

func _physics_process(delta: float) -> void:
	if _dest_inter:
		var dir := _dest_point - agent.global_position
		var nrm := Vector2(dir.x, dir.z).normalized()
		agent.movement = nrm
		agent.direction = lerp_angle(agent.direction, atan2(-nrm.y, nrm.x) - PI * .5, 5.0 * delta)
		agent.head_looking_at = _dest_inter.global_position
		if dir.length() <= 2.0:
			#print("Reached ", _dest_inter)
			_dest_inter = null
	else:
		var inter := Group.rand(&"Interactive")
		#print("goto ", inter)
		goto(inter)

func goto(inter: Interactive) -> void:
	_dest_inter = inter
	_dest_point = inter.global_position
