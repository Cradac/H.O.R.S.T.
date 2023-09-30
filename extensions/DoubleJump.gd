extends Extension

var used_jump = false
var last_on_floor = Time.get_ticks_msec()
@export var delay = 100 


func handle_action(character: Player, delta):
	if !character.is_on_floor():
		if Input.is_action_just_pressed("jump") && can_use():
			#character.velocity.y = 0
			character.jump(character.JUMP_FORCE)
			used_jump = true
	else:
		used_jump = false
		last_on_floor = Time.get_ticks_msec()
		
func can_use():
	var diff = (Time.get_ticks_msec() - last_on_floor)
	return (diff > delay) && !used_jump
