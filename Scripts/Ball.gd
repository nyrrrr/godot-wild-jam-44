extends KinematicBody2D

class_name Ball
signal check_game_status

export(int) var speed = 111

var rng = RandomNumberGenerator.new()
var velocity: Vector2 = Vector2.ZERO

func _ready():
	rng.randomize()
	velocity = Vector2(rng.randf_range(-1, 1), -1).normalized()
	speed = speed + (275 - get_tree().get_nodes_in_group("Blocks").size()) * 0.25

func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * speed * delta)
	if collision:
		$AudioStreamPlayer2D.play()
		velocity = velocity.bounce(collision.normal)
		if collision.collider is Block:
			speed += 0.25
			collision.collider.queue_free()
			emit_signal("check_game_status")
