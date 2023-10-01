class_name ChargedJumpItem extends Area2D

var picked_up = false

func _on_body_entered(body):
	if !picked_up:
		(body as Player).equip(ChargedJump.new())
		picked_up = true
		visible = false
