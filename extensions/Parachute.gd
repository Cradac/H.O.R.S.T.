class_name Parachute extends Extension

@export var name = "Parachute"
@export var gravity = 50
@export var texture: Texture2D
var orig_gravity 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_drop(character: Player):
	character.get_node("BadAsset01").visible = false
	character.offset = 0

func handle_action(character: Player, delta):
	character.get_node("BadAsset01").visible = true
	character.offset = character.DOWN_GRAVITY - gravity
	
func get_name():
	return name
	
func get_texture():
	return load("res://material/bad_asset_01.png")
