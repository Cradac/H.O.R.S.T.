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
@onready var rocket_sprite_r = $AnimatedSprite2D/RocketBoost_right
@onready var rocket_sprite_l = $AnimatedSprite2D/RocketBoost_left

var extensions: Array[Extension]
var items: Array[Key]
var prev_x = 1
var normal_jump = true
var in_jump = false
var offset = 0
var queued_vel = false
var queued_velocity: Vector2
var on_wall = false
var bounce_dir = 0

signal skill_inventory_change(extensions: Array[Extension])
signal item_inventory_change(items: Array[Key])
signal send_message(message: String, duration: int)

func _ready():
	rocket_sprite_r.visible = false
	rocket_sprite_l.visible = false

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
			var high_friction = (abs(velocity.x)/VELOCITY_THRESHOLD)*FRICTION_FACTOR
			var friction = max(high_friction, BASE_FRICTION)
			apply_friction(friction * delta)
			if not Input.is_action_pressed("jump"):
				_animated_sprite.play("idle")
				
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
		if is_on_floor() && not Input.is_action_pressed("jump"):
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
	
	# move rigid bodies
	for ext in extensions:
		if ext.get_name() == "Strength":
			for col_idx in get_slide_collision_count():
				var col := get_slide_collision(col_idx)
				if col.get_collider() is RigidBody2D:
					col.get_collider().apply_central_impulse(Vector2(col.get_normal().x, 0) * -35)
	
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
	get_node("JumpSound").play()
	
func may_i_jump():
	#this is a place for doublejump logic and other funky jumpy stuff
	if is_on_floor():
		return true
	return false

func action():
	if Input.is_action_just_pressed("action"):
		pass
	if Input.is_action_just_pressed("drop_first"):
		drop(0)
	if Input.is_action_just_pressed("drop_second"):
		drop(1)
		
	if Input.is_action_just_pressed("Retry"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file("res://ui/MainMenu.tscn")
	
		
func equip(extension: Extension) -> bool:
	if (extensions.size() >= ram_size):
		send_message.emit("Can't pick up '"+extension.get_name()+"'. Limited memory space.", 3)
		# TODO Add Warning Message to UI
		return false
	
	extension.handle_pickup(self)
	extensions.push_back(extension)
	
	skill_inventory_change.emit(extensions)
	send_message.emit("Picked up '"+extension.get_name()+"'.", 3)
	return true
	
func drop(slot_index: int):
	print("Dropping "+str(slot_index) + " - " + str(extensions.size()))
	if slot_index >= extensions.size():
		return
	else:
		send_message.emit("Dropped '"+extensions[slot_index].get_name()+"'.", 3)
		extensions[slot_index].handle_drop(self)
		extensions[slot_index].spawn_item(self)
		
		extensions.remove_at(slot_index)
		skill_inventory_change.emit(extensions)
	get_node("DropSound").play()

func pickup(item):
	items.append(item)
	item_inventory_change.emit(items)
	send_message.emit("Picked up 'Key'.", 3)
	
func remove_item(item):
	items.erase(item)
	item_inventory_change.emit(items)
	send_message.emit("Removed 'Key'.", 3)
	
func _on_collideLeft_body_entered(body):
	if body != self:
		on_wall = true
		bounce_dir = 1
		

func _on_collideLeft_body_exited(body):
	on_wall = false

func _on_collideRight_body_entered(body):
	if body != self:
		on_wall = true
		bounce_dir = -1
		

func _on_collideRight_body_exited(body):
	on_wall = false
