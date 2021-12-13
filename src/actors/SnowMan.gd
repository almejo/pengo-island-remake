extends KinematicBody2D

var speed: Vector2 = Vector2(150.0, 0.0)
var velocity: = Vector2.ZERO
var direction: = Vector2(-1.0, 0.0)
var original_pos: Vector2
var death_timer: = Timer.new()
onready var explosion_scene = preload("res://src/actors/EnemyExplosion.tscn")

func _ready():
	$AnimatedSprite.play("moving")
	original_pos = position
	death_timer.connect("timeout", self, "die")
	death_timer.one_shot = true
	add_child(death_timer)
	
func die():
	queue_free()
	
func _physics_process(delta):
	velocity.x = speed.x * direction.x
	velocity = move_and_slide(velocity)
	if original_pos.x - position.x > 100:
		direction.x *= -1
		$AnimatedSprite.flip_h = true
	elif position.x - original_pos.x > 100:
		direction.x *= -1
		$AnimatedSprite.flip_h = false

func _on_HitBox_body_entered(body):
	if body is SnowBall:
		var explosion = explosion_scene.instance()
		explosion.position = position
		get_tree().current_scene.add_child(explosion)
		explosion.emitting = true
		die()
	
