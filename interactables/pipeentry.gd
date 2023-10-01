class_name PipeEntry extends Area2D

@export var Target : PipeEntry
var received 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if !received:
		Target.received = true
		area.set_position(Target.position)
		pass # Replace with function body.


func _on_area_exited(area):
	received = false
	pass # Replace with function body.
