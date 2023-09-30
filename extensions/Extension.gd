class_name Extension
# This is the abstract class all extensions inherit
# Every function is NO-OP and overriden by the indivudual feature extensions as needed

func handle_action(character: Player, delta):
	pass
	
func handle_drop():
	# Handle cleanup of any lingering effects
	pass
