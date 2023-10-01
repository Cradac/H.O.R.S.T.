class_name Skillshard extends Area2D

@export var skill: Skill.Skills = Skill.Skills.OTHER
@onready var sprite: Sprite2D = $"Sprite2D"

var just_dropped = false
var picked_up = false
var extension: Extension

func update_extension():
	extension = Extension.get_extension(skill).new()
	sprite.texture = extension.get_texture()

func _ready():
	update_extension()

func _on_body_entered(body):
	if !picked_up and !just_dropped:
		if (body as Player).equip(extension):
			picked_up = true
			visible = false

func pick_skill(new_skill: Skill.Skills):
		skill = new_skill
		update_extension()


func _on_body_exited(body):
	just_dropped = false
	pass # Replace with function body.
