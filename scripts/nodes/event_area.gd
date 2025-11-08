extends Area3D

@export var trigger_zone := true
@export var zone_id: StringName

@export var toast_on_enter := true
@export var toast_on_exit := false

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
		State.ZONE_ENTERED.emit({ zone=zone, who=who })
		if toast_on_enter:
			var msg := "%s entered %s" % [who.name, zone.name]
			State.TOAST.emit({ type="simple_toast", data={text=msg} })

func _body_exited(body: Node3D):
	if not body is Agent: return
	var agent: Agent = body
	if trigger_zone and zone_id:
		var zone := State.find_zone(zone_id)
		var who := agent.char_info
		if not zone or not who: return
		State.ZONE_EXITED.emit({ zone=zone, who=who }) 
		if toast_on_exit:
			var msg := "%s exited %s" % [who.name, zone.name]
			State.TOAST.emit({ type="simple_toast", data={text=msg} })
