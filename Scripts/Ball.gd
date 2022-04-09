extends KinematicBody2D

class_name Ball

export(int) var speed = 150

var rng = RandomNumberGenerator.new()
var velocity: Vector2 = Vector2.ZERO

func _ready():
	rng.randomize()
	velocity = Vector2(rng.randf_range(-1, 1), -1).normalized()

func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * speed * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider is Block:
			collision.collider.queue_free()
