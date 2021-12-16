extends KinematicBody2D

class_name Enemy

var speed: Vector2 = Vector2(rand_range(100.0, 250.0), 0.0)
var velocity: = Vector2.ZERO
var direction: = Vector2(-1.0, 0.0)
var original_pos: Vector2
var death_timer: = Timer.new()
onready var explosion_scene = preload("res://src/actors/EnemyExplosion.tscn")

func _ready():
	print(name + " " + str(speed))
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
