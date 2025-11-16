@abstract class_name OSBase extends Resource

func _init(info: Dictionary) -> void:
	for prop in info:
		if prop in self:
			self[prop] = info[prop]
