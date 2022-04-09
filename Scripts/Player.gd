extends KinematicBody2D

signal game_over

export(int) var speed = 40
export(int) var acceleration = 300
export(int) var friction = 200

var ball

var health = 3

var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("Full")
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	get_input_vector()
	if input_vector.x != 0:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_collide(velocity)

			
func get_input_vector():
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
func decrease_health():
	health -= 1
	match health:
		2:
			$AnimationPlayer.play("Middle")
		1:
			$AnimationPlayer.play("Small")
		0:
			emit_signal("game_over")

