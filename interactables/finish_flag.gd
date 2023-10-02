class_name FinishFlag extends Sprite2D

@export var target_scene: String

func _on_area_2d_body_entered(body):
	if body is Player:
		var audio = get_node("AudioStreamPlayer2D")
		if !audio.is_playing():
			audio.play()

func _on_audio_stream_player_2d_finished():
	get_tree().change_scene_to_file(target_scene)
	pass # Replace with function body.
