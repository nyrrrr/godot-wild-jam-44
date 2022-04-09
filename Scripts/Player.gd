extends KinematicBody2D

export(int) var speed = 40
export(int) var acceleration = 300
export(int) var friction = 200

var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

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

