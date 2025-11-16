@tool
class_name FPPolygon extends Polygon2D

var root: FPRoot:
	get: return owner

@export var depth := 1.0
@export var operation := CSGShape3D.OPERATION_UNION
@export var material_3d: Material

func _draw() -> void:
	var font := ThemeDB.fallback_font
	var fsize := ThemeDB.fallback_font_size
	for i in polygon.size():
		var a := polygon[i-1]
		var b := polygon[i]
		var pixel_dist := (a - b).length()
		var meters := pixel_dist / float(root.pixels_per_meter)
		var label := "%sm" % meters 
		var center := (a + b) * .5
		center -= font.get_string_size(label, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize) * .5
		center.y += font.get_ascent(fsize)
		var clr := Color.WHITE
		draw_string(font, center, label, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize, clr)
