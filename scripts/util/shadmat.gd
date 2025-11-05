@tool
class_name ShadMat extends RefCounted

var material: ShaderMaterial
var _tween: Tween

func _init(obj: Variant, props: Dictionary) -> void:
	if obj is Material:
		material = obj
	elif obj is Node:
		if "material" in obj:
			material = obj.material
	for prop in props:
		material.set_shader_parameter(prop, props[prop])

#func _get(property: StringName) -> Variant:
	#return material.get_shader_parameter(property)
#
#func _set(property: StringName, value: Variant) -> bool:
	#material.set_shader_parameter(property, value)
	#return true

func tween(property: StringName, value: Variant, duration := 0.5, trans := Tween.TRANS_LINEAR, ease := Tween.EASE_IN_OUT):
	var from: Variant = convert(material.get_shader_parameter(property), typeof(value))
	if _tween: _tween.kill()
	_tween = Global.create_tween()
	_tween.tween_method(func(x): material.set_shader_parameter(property, x), from, value, duration)\
		.set_trans(trans)\
		.set_ease(ease)
