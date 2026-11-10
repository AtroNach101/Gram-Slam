extends RigidBody2D

var SPEED = 300
var attack = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(attack)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	ignore_blocks_below_attack()
	if body.is_in_group("blocks"):
		body.hit(attack)
		if Globals.actual_score >= 10 * attack:
			level_up()
	if body.name == "Paddle":
		Globals.score -=2
		var bounce_angle_cos : float = 0.9* (body.global_position.x - global_position.x) / ((body.size.x+$CollisionShape2D.shape.size.x) / 2) #range is +1 to -1 
										#this 0.9 coefficient is here for --2 reasons--> 1 reason
											# 1. to dampen the harsher angles that just slow down gameplay
											#-- 2. to prevent instances where the cosine is less than -1 or greater than +1 --
											# I just decided to not be lazy and make a solution. The denominator for the angle is now the size of the paddle + the size of the ball so it'll never go out of range as long as it is colliding.
		var bounce_angle_sin = sqrt(1.0 - bounce_angle_cos*bounce_angle_cos) 
		var new_velocity = Vector2(-SPEED*bounce_angle_cos,-SPEED*bounce_angle_sin)
		linear_velocity = new_velocity
		
func level_up() -> void:
	attack += 1
	$Label.text = str(attack)
	Globals.actual_score = 0

func ignore_blocks_below_attack() -> void:
	for i in get_tree().get_nodes_in_group("blocks"):
		if i.health < attack:
			i.set_collision_layer_value(1, false)
			i.set_collision_layer_value(2, true)
