class_name Strength extends Extension

var used_jump = false
var last_on_floor = Time.get_ticks_msec()
@export var delay = 100
@export var name = "Strength"

func handle_drop(character: Player):
	var item = load("res://interactables/Skillshard.tscn").instantiate()
	item.just_dropped = true
	item.set_position(character.position + Vector2(0,5))
	character.get_parent().add_child(item)
	item.pick_skill(Skill.Skills.STRENGTH)

func handle_action(character: Player, delta):
	pass
		
func can_use():
	var diff = (Time.get_ticks_msec() - last_on_floor)
	return (diff > delay) && !used_jump

func get_name():
	return name

func get_texture():
	return load("res://material/Skillshards/Strength-Skillshard16x16.png")

func get_skill():
	return Skill.Skills.STRENGTH
