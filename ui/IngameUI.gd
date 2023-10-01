extends Control

@onready var skill_inventory = $SkillInventoryUI
@onready var item_inventory = $ItemInventoryUI
@onready var player: Player = $"../Character"
@onready var label: Label = $"Message"
@onready var timer: Timer = $"Message/Timer"
@onready var name_label = $"LevelName"

@export var level_name: String = "Level X: <b3st13v31>"



func _ready():
	player.skill_inventory_change.connect(_on_skill_inventory_change)
	player.item_inventory_change.connect(_on_item_inventory_change)
	player.send_message.connect(_on_message)
	setup_empty_skills()
	name_label.text = level_name
	


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
		
		textureRect.texture = load("res://material/key_animated_texture.tres")
		item_inventory.add_child(textureRect)

func clear_item_inventory():
	for child in item_inventory.get_children():
		item_inventory.remove_child(child) 
		

func _on_message(message: String, duration: int):
	label.text = message
	timer.start(duration)
	
	
func _on_timer_timeout():
	label.text = ""
