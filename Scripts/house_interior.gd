extends Node2D

func _on_exit_area_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
