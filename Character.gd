class_name Player extends CharacterBody2D

@export var MAX_SPEED = 200
@export var ACCELERATION = 300
@export var FRICTION = 500
@export var JUMP_FORCE = 250 
@export var GRAVITY = 500
@export var ram_size = 1
@onready var _animated_sprite = $AnimatedSprite2D

var extensions: Array[Extension]
var prev_x = 1

func _process(delta):
	# action inputs
	action()
	for extension in extensions:
		extension.handle_action(self, delta)

func _physics_process(delta):
	move(delta)
	

@onready var axis = Vector2.ZERO

const DoubleJump = preload("res://extensions/DoubleJump.gd")

func move(delta):
	var x  = 0
	x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if x == 0:
		if is_on_floor():
			apply_friction(FRICTION * delta)
			_animated_sprite.play("idle")
	else:
		if sign(x) == sign(prev_x):
			if abs(velocity.x) <= MAX_SPEED:
				velocity.x += x * ACCELERATION * delta
		else:
			velocity.x = velocity.x / 2
			velocity.x = x * ACCELERATION * delta
		_animated_sprite.play("walk")
		if x > 0:
			_animated_sprite.set_flip_h(false)
		if x < 0:
			_animated_sprite.set_flip_h(true)

		
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump") and may_i_jump():
		jump(JUMP_FORCE)

	print(velocity)
	get_node("speed").text = str(velocity.x) + "" + str(velocity.y)
	move_and_slide()
	prev_x = x

func apply_friction(ammount):
	if velocity.length() > ammount:
		velocity -= velocity.normalized() * ammount
	else:
		velocity = Vector2.ZERO
		

func jump(force):
	velocity.y -= force
	_animated_sprite.play("jump")

func may_i_jump():
	#this is a place for doublejump logic and other funky jumpy stuff
	return is_on_floor()

func action():
	if Input.is_action_pressed("action"):
		extensions.push_back(DoubleJump.new())
		get_node("Label").visible = true
	else:
		get_node("Label").visible = false
