extends CharacterBody2D

class_name Ball

signal out_bounds

@export var initial_speed = 20
@export var speed_multiplier = 1.02

var ball_speed = initial_speed

func _ready():
	start_ball()

func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if(collision):
	# change direction
		velocity =  velocity.bounce(collision.get_normal()) * speed_multiplier
		$Choque.play()
		
		
func start_ball():
	randomize()
	velocity.x = [-1, 1][randi() % 2] * initial_speed
	velocity.y = [-.8, .8][randi() % 2] * initial_speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	emit_signal("out_bounds")
