class_name Player extends CharacterBody2D

@export var MAX_SPEED = 110
@export var ACCELERATION = 200
@export var AIR_BREAK = 100
@export var BASE_FRICTION = 500
@export var VELOCITY_THRESHOLD = 200
@export var FRICTION_FACTOR = 1500
@export var JUMP_FORCE = 250 
@export var GRAVITY = 500
@export var DOWN_GRAVITY = 1500
#@export var POST_JUMP_GRAVITY = 500
@export var ram_size = 1
@onready var _animated_sprite = $AnimatedSprite2D

var extensions: Array[Extension]
var items: Array[Key]
var prev_x = 1
var normal_jump = true
var in_jump = false
var offset = 0
var queued_vel = false
var queued_velocity: Vector2

signal skill_inventory_change(extensions: Array[Extension])
signal item_inventory_change(items: Array[Key])

func _process(delta):
	# action inputs
	action()
	

func _physics_process(delta):
	for extension in extensions:
		extension.handle_action(self, delta)
	move(delta)
	if not is_on_floor():
		_animated_sprite.play("jump")
	

@onready var axis = Vector2.ZERO

func move(delta):
	var x  = 0
	x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if x == 0 or abs(velocity.x) > VELOCITY_THRESHOLD:
		if is_on_floor():
			var friction = min((abs(velocity.x)/VELOCITY_THRESHOLD)*FRICTION_FACTOR, BASE_FRICTION)
			apply_friction(friction * delta)
			_animated_sprite.play("idle")
		if abs(velocity.x) > VELOCITY_THRESHOLD:
			_animated_sprite.play("walk")
	else:
		if sign(x) == sign(prev_x):
			if is_on_floor():
				velocity.x += x * ACCELERATION * delta
			else:
				velocity.x += (x * (ACCELERATION/2) * delta) 
		else:
			velocity.x = velocity.x / 2
			if is_on_floor():
				velocity.x = x * ACCELERATION * delta
			else:
				velocity.x = x * (ACCELERATION /2) * delta
		
		if abs(velocity.x) > MAX_SPEED:
			velocity.x = MAX_SPEED * sign(velocity.x)
		# Animations
		if is_on_floor():
			_animated_sprite.play("walk")
		if x > 0:
			_animated_sprite.set_flip_h(false)
		if x < 0:
			_animated_sprite.set_flip_h(true)
			
	if sign(velocity.y) == 1:
		velocity.y += (DOWN_GRAVITY - offset)* delta # normal gravity falling
	else:
		velocity.y += GRAVITY * delta # normal gravity rising
		
	#reset jump state
	if Input.is_action_just_pressed("jump") and may_i_jump() and normal_jump:
		queue_jump(JUMP_FORCE)
		
	
	# Apply velocity queued by Extensions
	velocity = velocity + queued_velocity
	
	queued_velocity = Vector2(0,0)
	
	get_node("speed").text = str( round(velocity.x) ) + " | " + str( round(velocity.y))
	move_and_slide()
	if is_on_floor() and in_jump:
		in_jump = false
	
	if is_on_floor() and velocity.y > 100:
		print("dead")
	
	prev_x = x

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
		

func queue_move(vec):
	queued_vel = true
	queued_velocity = vec

func queue_jump(force):
	in_jump = true
	queued_velocity.y +=  velocity.y * -1
	queued_velocity.y -= force
	_animated_sprite.play("jump")

func may_i_jump():
	#this is a place for doublejump logic and other funky jumpy stuff
	if is_on_floor():
		return true
	return false

func action():
	if Input.is_action_just_pressed("action"):
		#equip(ChargedJump.new())
		#equip(DoubleJump.new())
		#equip(Parachute.new())
		get_node("Label").visible = true
	else:
		get_node("Label").visible = false
		
	if Input.is_action_just_pressed("drop_first"):
		drop(0)
	if Input.is_action_just_pressed("drop_second"):
		drop(1)
		
func equip(extension: Extension) -> bool:
	if (extensions.size() >= ram_size):
		push_warning("Missing ram to pick up "+str(extension))
		# TODO Add Warning Message to UI
		return false
	
	extension.handle_pickup(self)
	extensions.push_back(extension)
	
	skill_inventory_change.emit(extensions)
	return true
	
func drop(slot_index: int):
	print("Dropping "+str(slot_index) + " - " + str(extensions.size()))
	if slot_index >= extensions.size():
		return
	else:
		extensions[slot_index].handle_drop(self)
		extensions.remove_at(slot_index)
		
		skill_inventory_change.emit(extensions)

func pickup(item):
	items.append(item)
	item_inventory_change.emit(items)
	
func remove_item(item):
	items.erase(item)
	item_inventory_change.emit(items)
	

