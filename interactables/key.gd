class_name Key extends Area2D


func _on_body_entered(body):
	(body as Player).pickup(self)
	queue_free()
