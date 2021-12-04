extends KinematicBody2D

export var speed: Vector2 = Vector2(200.00, 1050.0)
var _velocity: Vector2 = Vector2.ZERO
export var gravity: float = 4000.0

func _physics_process(delta):
	_velocity.y += gravity * delta
		
	var direction: = get_direction()
	play_animation()
	_velocity =  calculate_move_velocity(_velocity, direction, speed, false)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func play_animation():
	if Input.is_action_pressed("left"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
