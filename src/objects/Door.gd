extends Area2D

class_name Door

func _ready():
	$CollisionShape2D.disabled = false

func _on_Door_body_entered(body: KinematicBody2D):
	if body is Pengo:
		$CollisionShape2D.disabled = true
		$AnimatedSprite.play("open")
	
	
