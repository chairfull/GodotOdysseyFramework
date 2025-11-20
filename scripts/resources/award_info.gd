class_name AwardInfo extends DatabaseObject

@export var desc: String
@export var icon: String
@export var hint: String ## Text shown when locked.
@export var events: Array[StringName] ## Events to check condition on.
@export var cond: String ## Condition that when true will unlock.
@export var expr_progress := "" ## Expression for calculating progress.
@export var expr_max_progress := "" ## Expression for calculating max progress.
@export var unlocked: bool
@export var unlocked_date: String = ""
@export var progress: float = -1.0

func connect_signals():
	for event_id in events:
		var event: Event = World[event_id]
		event.connect_to(_event)

func _event(e: Event):
	if unlocked: return
	if not e.id in events: return
	if not World.test(cond): return
	var new_progress: float = World.expression(expr_progress)
	if new_progress == progress: return
	World.AWARD_PROGRESSED.fire({ award=self, old=progress, new=new_progress })
	progress = new_progress
	var max_progress: float = World.expression(expr_max_progress)
	if progress <= max_progress: return
	unlocked = true
	unlocked_date = "TODO"
	World.AWARD_UNLOCKED.fire({ award=self })
	
func set_unlocked(u: bool):
	if unlocked == u: return
	unlocked = u
	
	World.AWARD_UNLOCKED.fire()
	for event_id in events:
		World[event_id].disconnect(_event)
