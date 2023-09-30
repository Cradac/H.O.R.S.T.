extends Control

@onready var skill_inventory = $SkillInventoryUI
@onready var player: Player = $"../Character"


func _on_character_inventory_change(extensions):
	print(str(extensions))
	clear_skill_inventory()
	for i in range(extensions.size()):
		var label = Label.new()
		var extension = extensions[i]
		label.text = str(i+1) + ": " + extension.get_name()
		skill_inventory.add_child(label)

func clear_skill_inventory():
	for child in skill_inventory.get_children():
		skill_inventory.remove_child(child) 
