class_name DoubleJumpItem extends Area2D

var picked_up = false

func _on_body_entered(body):
	if !picked_up:
		(body as Player).equip(DoubleJump.new())
		picked_up = true
		visible = false
