extends Node

@onready var quest_list_parent: Container = %quest_list_parent
@onready var quest_list_prefab: VBoxContainer = %quest_list_prefab
@onready var quest_button_prefab: Container = %quest_button_prefab
@onready var quest_info: RichTextLabel = %quest_info
@onready var tick_prefab: Control = %tick_prefab
@onready var tick_parent: Control = %tick_parent
var quest: QuestInfo

func _ready() -> void:
	quest_button_prefab.get_parent().remove_child(quest_button_prefab)
	quest_list_parent.remove_child(quest_list_prefab)
	tick_parent.remove_child(tick_prefab)
	
	await get_tree().process_frame
	
	for q: QuestInfo in State.quests:
		q.changed.connect(_refresh)
		for tick in q.ticks:
			tick.changed.connect(_refresh)
	
	_refresh()
	_select_quest(State.quests._objects.values()[0])
	
func _refresh():
	_refresh_quest_list()
	_refresh_quest_info()

func _refresh_quest_list():
	var quest_lists := {}
	
	for child in quest_list_parent.get_children():
		quest_list_parent.remove_child(child)
		child.queue_free()
	
	for q: QuestInfo in State.quests:
		var style: String = QuestInfo.Style.keys()[q.style]
		if not style in quest_lists:
			var list := quest_list_prefab.duplicate()
			quest_list_parent.add_child(list)
			list.get_node("label").text = style
			quest_lists[style] = list
		
		var quest_button: Node = quest_button_prefab.duplicate()
		quest_lists[style].get_node("list").add_child(quest_button)
		#btn.quest = q
		var btn := quest_button.get_node("button")
		btn.name = q.id
		btn.text = q.name
		btn.modulate = QuestInfo.get_style_color(q.style)
		btn.pressed.connect(_select_quest.bind(q))

func _refresh_quest_info():
	UNode.remove_children(tick_parent)
	
	if quest:
		quest_info.text = "%s\n[i]%s]" % [quest.name, quest.desc]
		
		for tick: QuestTick in quest.ticks:
			var tk := tick_prefab.duplicate()
			tick_parent.add_child(tk)
			tk.text = "%s/%s %s" % [tick.tick, tick.max_ticks, tick.name]
			#tk.tick = tick
	else:
		quest_info.text = ""

func _select_quest(q: QuestInfo):
	quest = q
	_refresh_quest_info()

#func _descend(quest: Quest):
	#for goal in quest:
		#quest_info.text += "\t[i]%s[/i]: [i]%s[/i]\n" % [goal.name, goal.desc]
		#_descend(goal)
