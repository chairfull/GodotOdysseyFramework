@tool
class_name RTxtOE_Rainbow extends RTxtOutlineEffect

@export_group("Rainbow", "rainbow_")
@export_range(0.0, 1.0) var rainbow_saturation := 1.0
@export_range(0.0, 1.0) var rainbow_lightness := 0.8
@export_range(0.0, 1.0) var rainbow_frequency := 0.01
@export_range(0.0, 8.0) var rainbow_speed := 1.0
@export_range(1.0, 32.0) var rainbow_size := 8.0

func _update() -> bool:
	var list: Array = _char_fx.outline_states
	var n := list.size()
	for i in n:
		list[i].size = (1+i) * rainbow_size
		list[i].color = Color.from_ok_hsl(
			rnd_smoothu(rainbow_speed, rainbow_frequency, 123.41),
			rainbow_saturation,
			rainbow_lightness,
			1.0 - (i+1.0) / float(n))
	return true
