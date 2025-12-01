class_name ObsidianFile extends Resource

@export var id: StringName
@export var path: String
@export var mtime := -1
@export var tags: Array[StringName]
@export var frontmatter: Dictionary[StringName, Variant]
@export var elements: Array[Dictionary]

func was_modified() -> bool:
	return FileAccess.get_modified_time(path) != mtime
