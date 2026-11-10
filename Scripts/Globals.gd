extends Node

var score = 10
var actual_score = 0
var dm = Label.new()
var t = Timer.new()
var highscore = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t.timeout.connect(_ondeathtimeout)
	t.one_shot = true
	t.ignore_time_scale = true
	add_child(t)
	
	var file = FileAccess.open("user://save_game.dat",FileAccess.READ)
	if file:
		highscore = file.get_var()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func death() -> void:
	t.start(1.5)
	dm.text = "YOU DIED"
	add_child(dm)
	dm.global_position = Vector2(get_window().size.x/2 -dm.size.x/2 , get_window().size.y*1.5/2.5)
	Engine.time_scale = 0

	if actual_score > highscore:
		highscore = actual_score
		var file = FileAccess.open("user://save_game.dat",FileAccess.WRITE)
		file.store_var(highscore)
	

func _ondeathtimeout() -> void:
	get_tree().reload_current_scene()
	remove_child(dm)
	score = 10
	actual_score = 0
	Engine.time_scale = 1
