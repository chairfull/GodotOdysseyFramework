@tool
class_name RTxtOE_Hypno extends RTxtOutlineEffect

func _update() -> bool:
	var list: Array = _char_fx.outline_states
	var n := list.size()
	for i in n:
		var phase := fmod(time + float(i), 1.0)
		var osize := lerp(i*10, i*10+10, phase)
		var is_odd := int(fmod(time + float(i), 2.)) % 2 == 0
		var ocolr := Color.GREEN_YELLOW if is_odd else Color.DEEP_PINK
		if i == n-1:
			ocolr.a = 1.0-phase
		list[i].size = osize
		list[i].color = ocolr
	return true
