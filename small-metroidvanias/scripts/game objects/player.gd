extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyot_time = $CoyotTime
@onready var before_jump = $BeforeJump
@onready var dash_time = $DashTime
@onready var dying_time = $DyingTime

@export var score: int = 0

var SPEED = 125.0
var JUMP_VELOCITY = -300.0
var DASH_LENGTH = 1000

@export var total_count_jumps_in_air: int = 0
var count_of_jumps_in_air: int = total_count_jumps_in_air

@export var total_count_of_dashes: int = 0
var count_of_dashes: int = total_count_of_dashes
@export var jump_with_dash: bool = false # for 1d level
var direction_for_dash

@export var can_control: bool = true
@export var can_tp: bool = true

@export var can_move_by_mouse: bool = false
var mouse_on_player: bool = false

@export var have_weapon: bool = false

func _physics_process(delta):
	if can_move_by_mouse and mouse_on_player and Input.is_action_pressed("left mouse button"):
		global_position.x = get_global_mouse_position().x
		global_position.y = get_global_mouse_position().y + 5
		velocity.x = 0
		velocity.y = 0
	elif not is_on_floor():
		velocity += get_gravity() * delta
	if can_control:
		react_to_the_input()
	

func react_to_the_input():
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		direction_for_dash = direction
		
	if count_of_dashes > 0 and Input.is_action_just_pressed("dash"):
		if jump_with_dash:
			velocity.y = JUMP_VELOCITY
		dash_time.start()
		SPEED *= 10
		velocity.x = direction_for_dash * SPEED * (2 if direction == 0 else 1)
		count_of_dashes -= 1
		move_and_slide()
		return
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or !coyot_time.is_stopped():
			velocity.y = JUMP_VELOCITY
			coyot_time.stop()
		elif count_of_jumps_in_air > 0:
			velocity.y = JUMP_VELOCITY
			count_of_jumps_in_air -= 1
		else:
			before_jump.start()
	
	if is_on_floor() and !before_jump.is_stopped():
		velocity.y = JUMP_VELOCITY
		before_jump.stop()
		
	if direction != 0:
		animated_sprite.flip_h = direction < 0
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("run")
		count_of_jumps_in_air = total_count_jumps_in_air
		count_of_dashes = total_count_of_dashes
		coyot_time.start()
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func killed():
	rotation += PI/2
	can_control = false
	dying_time.start()

func _on_dying_time_timeout():
	get_tree().reload_current_scene()

func _on_dash_time_timeout():
	SPEED /= 10

func _on_mouse_getting_in_player_mouse_entered():
	mouse_on_player = true


func _on_mouse_getting_out_player_mouse_exited():
	mouse_on_player = false
