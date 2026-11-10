extends StaticBody2D

var health = 1
var points = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(health)
	pass # Replace with function body.

func hit(n: int) -> void:
	health -= n
	if (health <= 0):
		die()
	else:
		$Label.text = str(health)

func drop() -> void:
	pass

func die() -> void:
	Globals.actual_score += points
	queue_free()

func set_health(n: int) -> void:
	health = n
	$Label.text = str(health)
	points = n
