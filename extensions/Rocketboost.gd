class_name RocketBoost extends Extension

var used_boost = false

@export var name = "Rocket Boost"

func handle_drop(character: Player):
	pass

func handle_action(character: Player, delta):
	if !used_boost:
		if Input.is_action_just_pressed("action"):
			used_boost = true
			boost(character)
			if character.velocity.x > 0:
				character.rocket_sprite_r.visible = true
			elif character.velocity.x < 0:
				character.rocket_sprite_l.visible = true
	else:
		
		if character.on_wall:
			used_boost = false
			character.rocket_sprite_r.visible = false
			character.rocket_sprite_l.visible = false
			
		else:
			boost(character)
			

func boost(character):
	var sign = 0
	if character._animated_sprite.flip_h:
		sign = -1
	else:
		sign = 1
	character.velocity.x = 800 * sign
	character.velocity.y = 0

func get_name():
	return name

func get_texture():
	return load("res://material/Skillshards/Rocketboost-Skillshard16x16.png")

func get_skill():
	return Skill.Skills.ROCKET_BOOST
