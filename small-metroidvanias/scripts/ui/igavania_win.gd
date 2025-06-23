extends Node2D

@onready var killed = $killed
@onready var total = $total

func _ready():
	var file = FileAccess.open("res://player_score", FileAccess.READ)
	var score = file.get_as_text() #(%Player.score)
	file.close()
	total.text = total.text + " " + score + ("000" if score != "0" else "")
	killed.text = killed.text + " " + score + ("\n\nWow, you pacifist" if score == "0" else ("\n\nVery good, there are no enemies here now" if score == "15" else ""))
	

func _on_try_again_button_down():
	
	get_tree().change_scene_to_file("res://scenes/ui/Start Menu.tscn")
