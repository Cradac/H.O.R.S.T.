extends Node2D

@export var door: Door
@onready var _inactive_sprite = $StaticBody2D/inactive



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pressed():
	_inactive_sprite.hide()

func released():
	_inactive_sprite.show()
