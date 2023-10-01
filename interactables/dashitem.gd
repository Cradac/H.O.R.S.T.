class_name DashItem extends Area2D

var picked_up = false

func _on_body_entered(body):
	if !picked_up:
#		(body as Player).equip(Dash.new())
		picked_up = true
		visible = false
