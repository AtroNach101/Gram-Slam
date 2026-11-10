extends CharacterBody2D


const SPEED = 400.0
var size

func _ready() -> void:
	size = $CollisionShape2D.shape.size

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	var v : Vector2
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		v.x = direction * SPEED
	else:
		v.x = move_toward(v.x, 0, SPEED)

	var collision = move_and_collide(v * delta)
