class_name UBit extends RefCounted
const FLAG_NONE = 1 << 0 
const FLAG_A= 1 << 1
const FLAG_B = 1 << 2

static func is_enabled(b: int, flag: int) -> int:
	return b & flag != 0

static func enable(b: int, flag: int) -> int:
	return b | flag

static func disable(b: int, flag: int):
	return b & ~flag
