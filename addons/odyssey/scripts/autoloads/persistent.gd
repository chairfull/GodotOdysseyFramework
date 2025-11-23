extends Node

@export var awards: AwardDB
@export var unlocks: StatDB
@export var donor := false ## Donated to development?

func _ready() -> void:
	awards = AwardDB.new()
	unlocks = StatDB.new()
	
	unlocks.add_flag(&"start_mall") # Alloow starting in the mall.
	unlocks.add_flag(&"start_costco") # Allow spawning in costco.
	unlocks.add_flag(&"start_trailer") # Allow spawning in the trailer park.
