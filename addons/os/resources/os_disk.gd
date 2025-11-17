class_name OSDisk extends OSDir

func delete_file() -> void:
	var trash_path := ""

## Files inside trash but not "deleted".
func get_trashed_files() -> void:
	pass

## Files inside trash but marked "deleted". They are hidden.
func get_deleted_files() -> void:
	pass

## Only marks files as "deleted" so they are hidden.
func clear_trash() -> void:
	pass
