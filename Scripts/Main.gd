extends Node2D


export(PackedScene) var ball_scene

var ball

func _ready():
	pass# instantiate_ball()

func _process(delta):
	if Input.get_action_strength("start_game") and !ball:
		instantiate_ball()
		
func instantiate_ball():
	ball = ball_scene.instance()
	add_child(ball)
	ball.global_position = $Player/BallStartPosition.global_position

func _on_DamageArea_body_entered(body):
	if body is Ball:
		body.queue_free()
		ball = null
		$Player.decrease_health()

func _on_Player_game_over():
	get_tree().reload_current_scene()
