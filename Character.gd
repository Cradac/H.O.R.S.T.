extends CharacterBody2D

@export var MAX_SPEED = 500
@export var ACCELERATION = 500
@export var FRICTION = 500
@export var JUMP_FORCE = 600 
@export var GRAVITY = 500

@onready var axis = Vector2.ZERO
@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	move(delta)
	action()

func move(delta):
	var x  = 0
	x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	
	if x == 0:
		if is_on_floor():
			apply_friction(FRICTION * delta)
			_animated_sprite.play("idle")
	else:
		velocity.x += x * ACCELERATION * delta
		_animated_sprite.play("walk")
		print()
		if x > 0:
			_animated_sprite.set_flip_h(false)
		if x < 0:
			_animated_sprite.set_flip_h(true)
		
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y -=  JUMP_FORCE
		_animated_sprite.play("jump")
		
	move_and_slide()

func apply_friction(ammount):
	if velocity.length() > ammount:
		velocity -= velocity.normalized() * ammount
	else:
		velocity = Vector2.ZERO

func action():
	if Input.is_action_pressed("action"):
		get_node("Label").visible = true
	else:
		get_node("Label").visible = false
