class_name Key extends Area2D

var picked_up = false

func _on_body_entered(body):
	if !picked_up && body is Player:
		(body as Player).pickup(self)
		picked_up = true
		visible = false
		get_node("AudioStreamPlayer2D").play()
