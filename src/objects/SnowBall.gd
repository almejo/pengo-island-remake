extends KinematicBody2D

class_name SnowBall

var velocity: Vector2 = Vector2(600, -600)
export var gravity: float = 4000.0

onready var particles = $Particles2D
var timer: Timer = Timer.new()
var collision_shape
var color: = Color(1.0, 1.0, 1.0, 1.0)
var radius: = 16

func _ready():
	collision_shape = get_node("CollisionShape2D").get_shape()
	add_child(timer)
	timer.connect("timeout", self, "melt")
	timer.one_shot = true
	timer.start(3)
	
func melt():
	queue_free() 	

func _physics_process(delta):
	velocity.y += gravity * delta
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision != null:
		if collision.collider.name != 'floors':
			print("collision: " + collision.collider.name)
		_on_impact(collision.normal)
		
func _on_impact(normal: Vector2):
	particles.emitting = false
	velocity = velocity.bounce(normal)
	velocity *= 0.5 + rand_range(-0.05, 0.05)
