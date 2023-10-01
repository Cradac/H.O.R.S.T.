class_name Extension
# This is the abstract class all extensions inherit
# Every function is NO-OP and overriden by the indivudual feature extensions as needed

func handle_action(character: Player, delta):
	pass
	
func handle_drop(character: Player):
	# Handle cleanup of any lingering effects
	pass
	
func handle_pickup(character: Player):
	# Handle setup of any effects
	pass
	
func get_name():
	return "GenericExtension"
	
func get_texture():
	return load("res://material/Skillshards/empty-Skillshard.png")
	
static func get_extension(skill: Skill.Skills):
	match skill:
		Skill.Skills.CHARGED_JUMP:
			return ChargedJump
		Skill.Skills.DOUBLE_JUMP:
			return DoubleJump
		Skill.Skills.PARACHUTE:
			return Parachute
		_:
			return Extension
	pass
