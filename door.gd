class_name Door extends Node2D


@onready var _animated_sprite = $StaticBody2D/AnimatedSprite2D
@onready var _collision_shape = $StaticBody2D/CollisionShape2D
@onready var _static_body_2d = $StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_door():
	_animated_sprite.play("open")
	_static_body_2d.set_collision_layer(0)
	
func close_door():
	_animated_sprite.play("close")
	_static_body_2d.set_collision_layer(1)
