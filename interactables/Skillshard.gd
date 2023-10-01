class_name Skillshard extends Area2D

@export var skill: Skill.Skills = Skill.Skills.OTHER
@onready var sprite: Sprite2D = $"Sprite2D"

var picked_up = false
var extension: Extension

func _ready():
	extension = Extension.get_extension(skill).new()
	sprite.texture = extension.get_texture()

func _on_body_entered(body):
	if !picked_up:
		if (body as Player).equip(extension):
			picked_up = true
			visible = false
