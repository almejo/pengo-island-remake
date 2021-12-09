extends KinematicBody2D

class_name Pengo

export var max_jump_velocity = -900.0
export var move_velocity = 250.0

var velocity: Vector2 = Vector2.ZERO
export var gravity: float = 4000.0

signal death

onready var animated_sprite = $AnimatedSprite
onready var foot_snow = $FootSnow
onready var state_machine = $StateMachine

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _physics_process(delta):
	pass
	
func _apply_movement():
	_get_input()
	velocity = move_and_slide(velocity, Vector2.UP)	

func _get_input():
	var move_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if state_machine.state == state_machine.states.death:
		velocity.x = 0
	else:
		velocity.x = move_velocity * move_direction #lerp(velocity.x, move_velocity * move_direction, 0.6)

func _on_KillArea_body_entered(body: KinematicBody2D):
	emit_signal("death")
