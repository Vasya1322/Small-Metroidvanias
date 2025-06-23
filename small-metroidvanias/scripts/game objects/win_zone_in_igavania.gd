extends Area2D

func _on_body_entered(body):
	var file = FileAccess.open("res://player_score", FileAccess.WRITE)
	file.store_string(str(%Player.score))
	file.close()
	get_tree().change_scene_to_file("res://scenes/ui/Igavania win.tscn")
