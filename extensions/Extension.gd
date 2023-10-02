class_name Extension
# This is the abstract class all extensions inherit
# Every function is NO-OP and overriden by the indivudual feature extensions as needed

func handle_action(character: Player, delta):
	pass
	
func handle_drop(character: Player):
	# Handle cleanup of any lingering effects
	pass
	
func spawn_item(character: Player):
	var item = load("res://interactables/Skillshard.tscn").instantiate()
	item.just_dropped = true
	item.set_position(character.position + Vector2(0,5))
	character.get_parent().add_child(item)
	item.pick_skill(get_skill())
	
func handle_pickup(character: Player):
	# Handle setup of any effects
	pass
	
func get_name() -> String:
	return "GenericExtension"
	
func get_texture():
	return load("res://material/Skillshards/empty-Skillshard16x16.png")
	
static func get_extension(skill: Skill.Skills):
	match skill:
		Skill.Skills.CHARGED_JUMP:
			return ChargedJump
		Skill.Skills.DOUBLE_JUMP:
			return DoubleJump
		Skill.Skills.PARACHUTE:
			return Parachute
		Skill.Skills.DASH:
			return Dash
		Skill.Skills.WALLJUMP:
			return WallJump
		Skill.Skills.STRENGTH:
			return Strength
		Skill.Skills.ROCKET_BOOST:
			return RocketBoost
		_:
			return Extension
	pass

func get_skill():
	return Skill.Skills.OTHER
