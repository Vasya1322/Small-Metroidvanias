extends Node
@onready var player = %Player

func take_item_to_player():
	var cur_scene = get_tree().current_scene.get_path()
	name = get_tree().current_scene.name
	
	match name :
		"double jump":
			player.total_count_jumps_in_air += 1
		"long jump":
			player.JUMP_VELOCITY -= 100
		"dash":
			player.total_count_of_dashes += 1
		"infite jumps2":
			player.total_count_jumps_in_air += 9999
		"very high jump":
			player.JUMP_VELOCITY -= 650
		"1d":
			player.total_count_of_dashes += 1
			player.jump_with_dash = true
		"metroidbrania":
			player.can_move_by_mouse = true
		"igavania":
			player.have_weapon = true
