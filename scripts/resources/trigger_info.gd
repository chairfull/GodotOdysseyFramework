class_name TriggerInfo extends Resource

@export var event: StringName
@export var state: Dictionary[StringName, Variant]
@export var condition: String
@export var flow_script: FlowScript

func check(evnt: Event) -> bool:
	if not State[event] == evnt: return false
	if not evnt.test(state): return false
	if condition and not State.call(condition): return false
	return true
