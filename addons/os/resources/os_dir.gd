class_name OSDir extends OSItem

## Files and dirs.
func get_items() -> Dictionary[StringName, OSItem]:
	var out: Dictionary[StringName, OSItem]
	out.merge(get_dirs())
	out.merge(get_files())
	return out

func get_dirs() -> Dictionary[StringName, OSDir]:
	return OperatingSystem.get_dirs_at(path)

func get_files() -> Dictionary[StringName, OSFile]:
	return OperatingSystem.get_files_at(path, OSFile)
