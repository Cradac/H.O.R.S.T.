class_name WallJump extends Extension

@export var name = "WallJump"

func handle_drop(character: Player):
	#spawn item
	var item = load("res://interactables/Skillshard.tscn").instantiate()
	item.just_dropped = true
	item.set_position(character.position + Vector2(0,5))
	character.get_parent().add_child(item)
	item.pick_skill(Skill.Skills.WallJump)

func handle_action(character: Player, delta):
	if character.on_wall and Input.is_action_just_pressed("jump") and !character.is_on_floor():
		if character.bounce_dir > 0:
			character._animated_sprite.set_flip_h(false)
		else:
			character._animated_sprite.set_flip_h(true)
		character.velocity = Vector2(0,0)
		character.queue_move(Vector2(character.bounce_dir * 250 ,-character.JUMP_FORCE))
		
func can_use():
	pass

func handle_pickup(character: Player):
	pass
	
func get_name():
	return name

func get_texture():
	return load("res://material/Skillshards/Skillshard16x16.png")
