extends Extension

var usedJump = false

func handle_action(character: Player, delta):
	print(usedJump)
	if !character.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			character.velocity.y -=  character.JUMP_FORCE
			character._animated_sprite.play("jump")
			usedJump = true
	else:
		usedJump = false
