class_name Player extends CharacterBody2D

@export var MAX_SPEED = 200
@export var ACCELERATION = 300
@export var AIR_BREAK = 100
@export var FRICTION = 500
@export var JUMP_FORCE = 250 
@export var GRAVITY = 500
@export var ram_size = 1
@onready var _animated_sprite = $AnimatedSprite2D

var extensions: Array[Extension]
var prev_x = 1
var normal_jump = true

func _process(delta):
	# action inputs
	action()
	for extension in extensions:
		extension.handle_action(self, delta)

func _physics_process(delta):
	move(delta)
	

@onready var axis = Vector2.ZERO

func move(delta):
	var x  = 0
	x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if x == 0:
		if is_on_floor():
			apply_friction(FRICTION * delta)
			_animated_sprite.play("idle")
	else:
		if sign(x) == sign(prev_x):
			if is_on_floor():
				velocity.x += x * ACCELERATION * delta
			else:
				velocity.x += (x * (ACCELERATION/2) * delta) # - (x * AIR_BREAK * delta)
		else:
			velocity.x = velocity.x / 2
			if is_on_floor():
				velocity.x = x * ACCELERATION * delta
			else:
				velocity.x = x * (ACCELERATION /2) * delta
		if abs(velocity.x) > MAX_SPEED:
			velocity.x = MAX_SPEED * sign(velocity.x)
		_animated_sprite.play("walk")
		if x > 0:
			_animated_sprite.set_flip_h(false)
		if x < 0:
			_animated_sprite.set_flip_h(true)

		
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump") and may_i_jump() and normal_jump:
		jump(JUMP_FORCE)
	get_node("speed").text = str( round(velocity.x) ) + " | " + str( round(velocity.y))
	move_and_slide()
	prev_x = x

func apply_friction(ammount):
	if velocity.length() > ammount:
		velocity -= velocity.normalized() * ammount
	else:
		velocity = Vector2.ZERO
		

func jump(force):
	velocity.y = 0
	velocity.y -= force
	_animated_sprite.play("jump")

func may_i_jump():
	#this is a place for doublejump logic and other funky jumpy stuff
	return is_on_floor()

func action():
	if Input.is_action_pressed("action"):
		equip(ChargedJump.new())
		get_node("Label").visible = true
	else:
		get_node("Label").visible = false
		
func equip(extension: Extension):
	extension.handle_pickup(self)
	extensions.push_back(extension)
	
func drop(slot_index):
	extensions[slot_index].handle_drop(self)
	extensions.remove_at(slot_index)
