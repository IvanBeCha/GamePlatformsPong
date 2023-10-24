extends RigidBody2D
const speed = 60000

@onready var ball 


func _ready():
	ball = get_tree().get_first_node_in_group("ball")

func _physics_process(delta):
	var direction = (ball.position - position).normalized()
	
	linear_velocity.y = direction.y * speed * delta
	
