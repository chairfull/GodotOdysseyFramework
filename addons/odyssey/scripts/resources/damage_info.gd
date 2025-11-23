class_name DamageInfo extends Resource

var _source: NodePath
var source: Node3D:
	get: return Global.get_node(_source)
var _target: NodePath
var target: Damageable:
	get: return Global.get_node(_target)
var amount: float
var type: StringName
var position: Vector3
var normal: Vector3
