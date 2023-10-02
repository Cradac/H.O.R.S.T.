class_name Dash extends Extension

var used_dash = false
var last_dashed = Time.get_ticks_msec()
@export var FORCE = 480
@export var delay = 1500
@export var name = "Dash"

func handle_drop(character: Player):
	pass

func handle_action(character: Player, delta):
	if (Input.is_action_just_pressed("action") or Input.is_action_just_pressed("action_2") or Input.is_action_just_pressed("dash") ) && can_use() :
		var sign = 0
		if character._animated_sprite.flip_h:
			sign = -1
		else:
			sign = 1
		character.queue_move(Vector2( sign * FORCE , -0.2 * FORCE))
		Input.start_joy_vibration(0,0.2,0,0.5)
		used_dash = true
		last_dashed = Time.get_ticks_msec()
	else:
		used_dash = false
		
	
func can_use():
	var diff = (Time.get_ticks_msec() - last_dashed)
	print(diff)
	return (diff > delay) && !used_dash

func get_name():
	return name

func get_texture():
	return load("res://material/Skillshards/Dash-Skillshard16x16.png")
	
func get_skill():
	return Skill.Skills.DASH
