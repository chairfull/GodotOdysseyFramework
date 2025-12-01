@tool
class_name ObsidianDB extends Resource

const PATH := "res://assets/obsidian_db.tres"

@export var files: Dictionary[String, ObsidianFile]
@export var tags: Array[StringName]
var root: String
var regex_autotag: RegEx

static var ref: ObsidianDB:
	get: return load(PATH)

static func regenerate() -> void:
	var obd := ObsidianDB.new()
	obd._update_files()
	ResourceSaver.save(obd, PATH)
	EditorInterface.get_resource_filesystem().reimport_files([PATH])

func _update_files() -> void:
	var old_files := files.size()
	tags.clear()
	files.clear()
	
	root = ProjectSettings.get_setting("odyssey/obsidian/vault_path", "")
	
	var autotags = ProjectSettings.get_setting("odyssey/obsidian/auto_tag", [])
	regex_autotag = RegEx.create_from_string("(?i)\\b(" + "|".join(autotags).to_lower() + ")\\b")
	
	_scan_dir(root)
	print("Found %s markdown files w %s tags." % [files.size(), tags.size()])

func _scan_dir(dir: String) -> void:
	for subdir in DirAccess.get_directories_at(dir):
		if not subdir.begins_with("."):
			_scan_dir(dir.path_join(subdir))
	for file in DirAccess.get_files_at(dir):
		if not file.begins_with(".") and file.get_extension() == "md":
			_scan_file(dir.path_join(file))

func _scan_file(path: String) -> void:
	var txt := FileAccess.get_file_as_string(path)
	var autotagged: Array[String]
	for m in regex_autotag.search_all(txt):
		autotagged.append(m.get_string())
	
	var md := Markdown.parse_file(path)
	var file := ObsidianFile.new()
	file.id = path.trim_prefix(root).trim_prefix("/").trim_suffix(".md")
	file.path = path
	file.mtime = FileAccess.get_modified_time(path)
	file.frontmatter.assign(md.frontmatter)
	file.tags.assign(md.tags + autotagged)
	#UList.append_unique(file.tags, autotagged)
	UList.append_unique(file.tags, UDict.pop(file.frontmatter, &"tags", []))
	UList.append_unique(tags, file.tags)
	print(file.id, file.tags)
	file.elements.assign(md.elements)
	files[file.id] = file
