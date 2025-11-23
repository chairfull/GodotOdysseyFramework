class_name UColor extends RefCounted

static func lerp_hsv(c1: Color, c2: Color, weight: float) -> Color:
	return Color.from_hsv(
		lerpf(c1.h, c2.h, weight),
		lerpf(c1.s, c2.s, weight),
		lerpf(c1.v, c2.v, weight),
		lerpf(c1.a, c2.a, weight))

static func lerp_ok_hsl(c1: Color, c2: Color, weight: float) -> Color:
	return Color.from_ok_hsl(
		lerpf(c1.ok_hsl_h, c2.ok_hsl_h, weight),
		lerpf(c1.ok_hsl_s, c2.ok_hsl_s, weight),
		lerpf(c1.ok_hsl_l, c2.ok_hsl_l, weight),
		lerpf(c1.a, c2.a, weight))
