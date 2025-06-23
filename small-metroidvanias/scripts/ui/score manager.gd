extends Label

@onready var player = %Player
var usual_text: String
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var was_blown_up: bool = false

func _ready():
	usual_text = text

func _process(delta):
	text = usual_text + str(player.score) + "000"
	if player.score == 15 and not was_blown_up:
		was_blown_up = true
		text = ""
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("default")
		audio_stream_player_2d.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
