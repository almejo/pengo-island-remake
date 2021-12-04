extends KinematicBody2D

var speed: Vector2 = Vector2(150.0, 0.0)
var velocity: = Vector2.ZERO
var direction: = Vector2(-1.0, 0.0)
var original_pos: Vector2

func _ready():
	$AnimatedSprite.play("moving")
	original_pos = position

func _physics_process(delta):
	velocity.x = speed.x * direction.x
	velocity = move_and_slide(velocity)
	if original_pos.x - position.x > 100:
		direction.x *= -1
		$AnimatedSprite.flip_h = true
	elif position.x - original_pos.x > 100:
		direction.x *= -1
		$AnimatedSprite.flip_h = false
	
