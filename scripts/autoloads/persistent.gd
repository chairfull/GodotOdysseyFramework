extends Node

@export var achievements: AchievementDB
@export var unlocks: VarDB
@export var donor := false ## Donated to development?

func _ready() -> void:
	achievements = AchievementDB.new()
	unlocks = VarDB.new()
	
	unlocks.add_flag(&"start_mall") # Alloow starting in the mall.
	unlocks.add_flag(&"start_costco") # Allow spawning in costco.
	unlocks.add_flag(&"start_trailer") # Allow spawning in the trailer park.
