extends Node2D

func turn_on_game(name):
	print("res://levels/" + name + ".tscn")
	get_tree().change_scene_to_file("res://levels/" + name + ".tscn")

func _on_double_jump_button_down():
	turn_on_game("double jump")

func _on_long_jump_button_down():
	turn_on_game("long jump")

func _on_dash_button_down():
	turn_on_game("dash")

func _on_only_double_jump_button_down():
	turn_on_game("infite jumps")

func _on_only_dash_button_down():
	turn_on_game("1d")

func _on_only_long_jump_button_down():
	turn_on_game("very high jump")
	

func _on_metroidbrania_button_down():
	turn_on_game("metroidbrania")

func _on_igavania_button_down():
	turn_on_game("igavania")
