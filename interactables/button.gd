extends Node2D

@export var door: Door
@onready var _inactive_sprite = $Area2D/inactive

@onready var is_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func press():
	_inactive_sprite.hide()
	is_pressed = true
	print("pressing")

func release():
	_inactive_sprite.show()
	is_pressed = false
	print("releasing")


func _on_area_entered(entryObject):
	if entryObject.get_collider() is RigidBody2D or CharacterBody2D:
		press()


func _on_body_exited(entryObject):
	if entryObject.get_collider() is RigidBody2D or CharacterBody2D:
		release()
	
