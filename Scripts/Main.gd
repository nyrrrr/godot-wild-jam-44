extends Node2D

onready var ball_scene = preload("res://Scenes/Ball.tscn")
onready var is_game_over = false

var ball

func _ready():
	$StartLabel.show() #show controls & play music
	$GameOverLabel.hide()
	$WonLabel.hide()

func _process(delta):
	if is_game_over and Input.get_action_strength("start_game"):
		get_tree().reload_current_scene()
	if Input.get_action_strength("start_game") and !ball:
		instantiate_ball()
		
func instantiate_ball():
	$GameOverLabel.hide()
	$StartLabel.hide()
	ball = ball_scene.instance()
	ball.connect("check_game_status", self, "_on_check_game_status")
	add_child(ball)
	ball.global_position = $Player/BallStartPosition.global_position

func _on_DamageArea_body_entered(body):
	if body is Ball:
		$DamageArea/AudioStreamPlayer2D.play()
		body.queue_free()
		ball = null
		$BlackScreen.visible = true
		yield(get_tree().create_timer(0.05), "timeout")
		$BlackScreen.visible = false
		$Player.decrease_health()

func _on_Player_game_over():
	is_game_over = true
	$GameOverLabel.show()
	$StartLabel.show()

func _on_check_game_status():
	var blocks = get_tree().get_nodes_in_group("Blocks").size()
	match blocks:
		200:
			$Music.pitch_scale = 1.08
		100:
			$Music.pitch_scale = 1.17
		0:
			end_game()

func end_game():
	ball.velocity = Vector2.ZERO
	is_game_over = true
	$WonLabel.show()
	$StartLabel.show()
