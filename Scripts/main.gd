extends Node2D

var startcount = 3

var block_scene = preload("res://Scenes/block.tscn")
const blocksize = Vector2(64.0,32.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ball.global_position.x = get_window().size.x /2
	$Paddle.global_position.x = get_window().size.x /2
	$StartTimer/Label.global_position.x = get_window().size.x /2 -$StartTimer/Label.size.x/2
	$Paddle/Score.text = "Life: " + str(Globals.score)
	$Highscore.text = "Highscore: " + str(Globals.highscore)
	
	
	for x in (get_window().size.x / (blocksize.x+10))-1 :
		for y in 7:
			var block = block_scene.instantiate()
			block.global_position = Vector2( (x+0.5) * (blocksize.x+10) + fmod(get_window().size.x ,(blocksize.x+10))/2, 50 + (blocksize.y+10) * y )
			block.add_to_group("blocks")
			add_child(block)
			block.set_health(7-y)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_timer_timeout() -> void:
	startcount -=1
	$StartTimer/Label.text = str(startcount) 
	if startcount == 0:
		$StartTimer/Label.visible = false
		$Ball.apply_impulse(Vector2(0,300)) #has same effect as setting the linear velocity


func _on_ball_body_entered(body: Node) -> void:
	$Paddle/Score.text = "Life: " + str(Globals.score)
	$ActualScore.text = "Score: " + str(Globals.actual_score)
