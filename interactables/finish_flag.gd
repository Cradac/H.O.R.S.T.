class_name FinishFlag extends Sprite2D

@export var target_scene: String

func _on_area_2d_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file(target_scene)
