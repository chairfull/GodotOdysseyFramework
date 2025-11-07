extends Area3D

@export var trigger_zone := true
@export var zone_id: StringName

func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func _body_entered(body: Node3D):
	if not body is Agent: return
	var agent: Agent = body
	if trigger_zone and zone_id:
		var zone := State.find_zone(zone_id)
		var who := agent.char_info
		if not zone or not who: return
		prints(who.name, "entered", zone.name)
		State.ZONE_ENTERED.emit({ zone=zone, who=who })

func _body_exited(body: Node3D):
	if not body is Agent: return
	var agent: Agent = body
	if trigger_zone and zone_id:
		var zone := State.find_zone(zone_id)
		var who := agent.char_info
		if not zone or not who: return
		prints(who.name, "exited", zone.name)
		State.ZONE_EXITED.emit({ zone=zone, who=who }) 
