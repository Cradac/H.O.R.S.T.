extends Control

@onready var skill_inventory = $SkillInventoryUI
@onready var item_inventory = $ItemInventoryUI
@onready var player: Player = $"../Character"


func _ready():
	player.skill_inventory_change.connect(_on_skill_inventory_change)
	player.item_inventory_change.connect(_on_item_inventory_change)
	pass


func _on_skill_inventory_change(extensions):
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
		
func _on_item_inventory_change(items):
	print(str(items))
	clear_item_inventory()
	for i in range(items.size()):
		var label = Label.new()
		#var extension = extensions[i]
		label.text = str(i+1) + ": Key"
		item_inventory.add_child(label)

func clear_item_inventory():
	for child in item_inventory.get_children():
		item_inventory.remove_child(child) 
