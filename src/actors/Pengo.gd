extends KinematicBody2D

class_name Pengo

var snow_ball_timer: Timer = Timer.new()
export var max_jump_velocity = -900.0
export var move_velocity = 250.0

var velocity: Vector2 = Vector2.ZERO
export var gravity: float = 4000.0

signal death

onready var animated_sprite = $AnimatedSprite
onready var foot_snow = $FootSnow
onready var state_machine = $StateMachine

var snow_ball_scene = preload("res://src/objects/SnowBall.tscn")
var last_direction = 1

func _ready():
	snow_ball_timer.one_shot = true
	add_child(snow_ball_timer)

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _physics_process(delta):
	pass
	
func _apply_movement():
	_get_input()
	velocity = move_and_slide(velocity, Vector2.UP)	

func _get_input():
	if Input.is_action_just_pressed("fire"):
		shoot_snow_ball()
		
	var move_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	#print (move_direction != 0)
	last_direction = move_direction if move_direction != 0.0 else last_direction
	#print(last_direction)
	if state_machine.state == state_machine.states.death:
		velocity.x = 0
	else:
		velocity.x = move_velocity * move_direction #lerp(velocity.x, move_velocity * move_direction, 0.6)

func _on_KillArea_body_entered(body: KinematicBody2D):
	emit_signal("death")

func shoot_snow_ball():
	if !snow_ball_timer.is_stopped():
		return
	var snow_ball = snow_ball_scene.instance()
	snow_ball.velocity.x *= last_direction
	snow_ball.position = position
	snow_ball.position.x += 20 * last_direction
	snow_ball.position.y -= 20.0
	get_tree().current_scene.add_child(snow_ball)
	snow_ball_timer.start(1)
