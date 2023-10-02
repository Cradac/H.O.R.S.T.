class_name PipeEntry extends Area2D

@export var Target : PipeEntry
var received 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_received(value):
	received = value
		

func _on_area_entered(entryObject: Skillshard):
	if !received and Target != null:
		Target.set_received(true)
		entryObject.hide()
		await get_tree().create_timer(2.0).timeout
		entryObject.show()
		get_node("AudioStreamPlayer2D").play()
		entryObject.set_position(Target.position)



func _on_area_exited(entryObject):
	received = false

