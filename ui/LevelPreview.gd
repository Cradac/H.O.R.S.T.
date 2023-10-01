class_name LevelPreview extends Control

@export var target_scene: PackedScene
@export var level_screenshot: Texture2D
@export var level_number: int

@onready var texture_rect = $"TextureRect"
@onready var label = $"Label"

func _on_button_pressed():
	get_tree().change_scene_to_packed(target_scene)
	
func _ready():
	texture_rect.texture = level_screenshot
	label.text = "Level " + str(level_number)
