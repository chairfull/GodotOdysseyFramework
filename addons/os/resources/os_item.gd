@abstract class_name OSItem extends OSBase

enum Type { TEXT, IMAGE, APP }

@export var name: String
@export var path: String # Full FS path, e.g., "/Disk1/Users/Guest/Desktop/"
@export var permissions: Array[StringName] = [&"read"] # ["read", "write", "execute"]
@export var hidden: bool = false
