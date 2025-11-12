class_name CharGroupInfo extends DatabaseObject

@export var desc: String

func get_chars(id: StringName) -> Array[CharInfo]:
	var out: Array[CharInfo]
	for ch: CharInfo in State.chars:
		if id in ch.groups:
			out.append(ch)
	return out
