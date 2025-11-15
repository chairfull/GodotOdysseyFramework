class_name TweeUtil extends RefCounted

const EASING := {
	&"EASE": Tween.EASE_IN_OUT,
	&"E": Tween.EASE_IN_OUT,
	&"EINOUT": Tween.EASE_IN_OUT,
	&"EASEIN": Tween.EASE_IN,
	&"EIN": Tween.EASE_IN,
	&"EASEOUT": Tween.EASE_OUT,
	&"EOUT": Tween.EASE_OUT,
	&"EASEOUTIN": Tween.EASE_OUT_IN,
	&"EOUTIN": Tween.EASE_OUT_IN,
}
const TRANSING := {
	&"LINEAR": Tween.TRANS_LINEAR,
	&"LIN": Tween.TRANS_LINEAR,
	&"SINE": Tween.TRANS_SINE,
	&"SIN": Tween.TRANS_SINE,
	&"QUINT": Tween.TRANS_QUINT,
	&"QUART": Tween.TRANS_QUART,
	&"QUAD": Tween.TRANS_QUAD,
	&"EXPO": Tween.TRANS_EXPO,
	&"ELASTIC": Tween.TRANS_ELASTIC,
	&"CUBIC": Tween.TRANS_CUBIC,
	&"CIRC": Tween.TRANS_CIRC,
	&"BOUNCE": Tween.TRANS_BOUNCE,
	&"BACK": Tween.TRANS_BACK,
	&"SPRING": Tween.TRANS_SPRING,
}

static func is_trans_ease(tok: String) -> bool:
	for ease in EASING:
		if ease == tok:
			return true
		for trans in TRANSING:
			if tok == ease + "_" + trans:
				return true
	return false

static func get_object_and_property(obj: Object, prop: String) -> Array:
	if obj is Node:
		var subnode: Node = obj
		if prop.begins_with("%"):
			var parts := prop.split(":", true, 1)
			subnode = obj.get_node_or_null(parts[0])
			prop = parts[1]
		var node_and_resource := subnode.get_node_and_resource(prop)
		var n: Node = node_and_resource[0]
		var r: Resource = node_and_resource[1]
		var p: NodePath = node_and_resource[2]
		return [r if r else n if n else obj, p if p else prop]
	else:
		return [obj, prop]
