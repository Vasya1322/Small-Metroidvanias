extends Area2D
@export var landing_zone: Marker2D


func _on_body_entered(body):
	if not body.can_tp: return
	body.can_tp = false
	body.global_position = landing_zone.global_position
	await get_tree().create_timer(0.2).timeout
	body.can_tp = true
