class_name Door extends Node2D


@onready var _animated_sprite = $StaticBody2D/AnimatedSprite2D
@onready var _collision_shape = $StaticBody2D/CollisionShape2D
@onready var _static_body_2d = $StaticBody2D

@export var key: Key
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_door():
	open = true
	_animated_sprite.play("open")
	await get_tree().create_timer(1.0).timeout
	_static_body_2d.set_collision_layer(0)
	
func close_door():
	_animated_sprite.play("close")
	_static_body_2d.set_collision_layer(1)


func _on_area_2d_body_entered(body):
	if (body == _static_body_2d) || open || !(body is Player):
		return
	var player: Player = body as Player
	for item in player.items:
		if item == key:
			open_door()
			player.remove_item(item)
			return
	player.send_message.emit("Missing correct key", 3)
	
