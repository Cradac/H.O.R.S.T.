class_name ChargedJump extends Extension

var started_charging
@export var charge_jump_force = 225.0 
@export var charge_duration = 1000.0
@export var name = "ChargedJump"

func handle_pickup(character: Player):
	character.normal_jump = false

func handle_action(character: Player, delta):
	if Input.is_action_just_released("jump") && character.is_on_floor():
		var time_charged = Time.get_ticks_msec() - started_charging
		var boost = min((time_charged/charge_duration)*charge_jump_force, charge_jump_force)
		print(str(time_charged) + " " + str(boost))
		character.queue_jump(character.JUMP_FORCE + boost)
	
	
	if Input.is_action_just_pressed("jump") && character.is_on_floor():
		#print("jump pressed")
		started_charging = Time.get_ticks_msec()
		character._animated_sprite.play("landing")
		
	if Input.is_action_pressed("jump"):
		character.velocity.x = 0

func handle_drop(character: Player):
	character.normal_jump = true
	
func get_name():
	return name
	
func get_texture():
	return load("res://material/Skillshards/ChargedJump-Skillshard16x16.png")
	
func get_skill():
	return Skill.Skills.CHARGED_JUMP
