class_name ChargedJump extends Extension

var started_charging
@export var charge_jump_force = 350.0 
@export var charge_duration = 1000.0


func handle_pickup(character: Player):
	character.normal_jump = false

func handle_action(character: Player, delta):
	if Input.is_action_just_released("jump") && character.is_on_floor():
		var time_charged = Time.get_ticks_msec() - started_charging
		var boost = min((time_charged/charge_duration)*charge_jump_force, charge_jump_force)
		print(str(time_charged) + " " + str(boost))
		character.jump(character.JUMP_FORCE + boost)
	
	
	if Input.is_action_just_pressed("jump") && character.is_on_floor():
		started_charging = Time.get_ticks_msec()
		
	if Input.is_action_pressed("jump") && character.is_on_floor():
		character._animated_sprite.play("landing")
		
func handle_drop(character: Player):
	character.normal_jump = true
