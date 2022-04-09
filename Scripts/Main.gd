extends Node2D

onready var ball_scene = preload("res://Scenes/Ball.tscn")

var ball

func _ready():
	pass

func _process(delta):
	if Input.get_action_strength("start_game") and !ball:
		instantiate_ball()
		
func instantiate_ball():
	ball = ball_scene.instance()
	ball.connect("check_game_status", self, "_on_check_game_status")
	add_child(ball)
	ball.global_position = $Player/BallStartPosition.global_position

func _on_DamageArea_body_entered(body):
	if body is Ball:
		body.queue_free()
		ball = null
		$BlackScreen.visible = true
		yield(get_tree().create_timer(0.05), "timeout")
		$BlackScreen.visible = false
		$Player.decrease_health()

func _on_Player_game_over():
	get_tree().reload_current_scene()

func _on_check_game_status():
	var blocks = get_tree().get_nodes_in_group("Blocks").size()
	if blocks == 0:
		end_game()

func end_game():
	pass
