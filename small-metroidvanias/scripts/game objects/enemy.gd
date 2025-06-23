extends Node2D

@onready var animation_player = $AnimationPlayer

func _on_kill_zone_body_entered(body):
	if !body.have_weapon:
		body.killed()
	else:
		animation_player.play("dying")
		body.score += 1
