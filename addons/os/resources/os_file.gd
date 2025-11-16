class_name OSFile extends OSItem

@export var override_extension := &""
@export var other: Dictionary[StringName, Variant]

func get_extension() -> StringName:
	if override_extension:
		return override_extension
	return path.get_extension()

func load_data() -> Variant:
	if not path.begins_with("user://") or path.begins_with("res://assets/"):
		push_error("Can't save to %s." % path)
		return null
	match get_extension():
		"txt", "json", "yaml", "md":
			return FileAccess.get_file_as_string(path)
		"png", "webp", "jpg", "jpeg":
			var bytes := FileAccess.get_file_as_bytes(path)
			var img := Image.new()
			var err: int
			match get_extension():
				"png": err = img.load_png_from_buffer(bytes)
				"webp": err = img.load_webp_from_buffer(bytes)
				"jpg", "jpeg": err = img.load_jpg_from_buffer(bytes)
			if not err == OK:
				push_error(error_string(err))
				return null
			return ImageTexture.create_from_image(img)
	return null

func save_data(data: Variant) -> bool:
	if not path.begins_with("user://") or path.begins_with("res://assets/"):
		push_error("Can't save to %s." % path)
		return false
	match get_extension():
		"txt", "json", "yaml", "md":
			if not data is String:
				push_error("TODO")
				return false
			var file := FileAccess.open(path, FileAccess.WRITE)
			file.store_string(data)
			file.close()
			return true
		"png", "webp", "jpg", "jpeg":
			var err: int
			var img := (data as Texture2D).get_image()
			match get_extension():
				"png": err = img.save_png(path)
				"webp": err = img.save_webp(path)
				"jpg", "jpeg": err = img.save_jpg(path)
			if not err == OK:
				push_error(error_string(err))
				return false
			return true
	return true
