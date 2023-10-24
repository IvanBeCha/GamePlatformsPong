extends Node2D

var player_points = 0
var enemy_points = 0

@onready var pause_menu = $UI/PauseMenu
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $Paddle
@onready var ball = $Ball
@onready var UI = $UI

var paused = false

func _ready():
	ball.connect("out_bounds", _on_ball_screen_exited)
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func enemy_scored():
	enemy_points += 1
	UI.update_enemy_points(enemy_points)
	await get_tree().create_timer(.5).timeout
	if enemy_points == 3:
		game_over()
	else:
		reset_game_state()

func player_scored():
	player_points += 1
	UI.update_player_point(player_points)
	await get_tree().create_timer(.5).timeout
	if player_points == 3:	
		game_over()
	else:
		reset_game_state()

func reset_game_state():
	enemy_paddle.global_position.y = 0
	player_paddle.global_position.y = 0
	ball.velocity = Vector2.ZERO
	enemy_paddle.linear_velocity = Vector2.ZERO
	player_paddle.linear_velocity = Vector2.ZERO
	ball.global_position = Vector2.ZERO
	ball.start_ball()
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused	
	
func _on_ball_screen_exited():
	reset_game_state()
	
func game_over():
	get_tree().quit()
