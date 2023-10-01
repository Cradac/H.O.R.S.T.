extends Control

@onready var skill_inventory = $SkillInventoryUI
@onready var item_inventory = $ItemInventoryUI
@onready var player: Player = $"../Character"


func _ready():
	player.skill_inventory_change.connect(_on_skill_inventory_change)
	player.item_inventory_change.connect(_on_item_inventory_change)
	setup_empty_skills()
	pass


func _on_skill_inventory_change(extensions: Array[Extension]):
	print(str(extensions))
	clear_skill_inventory()
	setup_empty_skills()
	for i in range(extensions.size()):
		var textureRect = skill_inventory.get_child(i)
		textureRect.texture = extensions[i].get_texture()

func clear_skill_inventory():
	for child in skill_inventory.get_children():
		skill_inventory.remove_child(child) 
		
func setup_empty_skills():
	for i in range(player.ram_size):
		var textureRect = TextureRect.new()
		textureRect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		textureRect.stretch_mode = TextureRect.STRETCH_SCALE
		
		textureRect.texture = Extension.new().get_texture()
		skill_inventory.add_child(textureRect)
		

func _on_item_inventory_change(items):
	print(str(items))
	clear_item_inventory()
	for i in range(items.size()):
		var textureRect = TextureRect.new()
		textureRect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		textureRect.stretch_mode = TextureRect.STRETCH_SCALE
		
		textureRect.texture = load("res://material/Robot Platform Pack/key.png")
		item_inventory.add_child(textureRect)

func clear_item_inventory():
	for child in item_inventory.get_children():
		item_inventory.remove_child(child) 
