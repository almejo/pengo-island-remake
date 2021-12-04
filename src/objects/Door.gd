extends Area2D

func _ready():
	$CollisionShape2D.disabled = false

func _on_Door_body_entered(body):
	if body.name == "Pengo":
		$CollisionShape2D.disabled = true
		$AnimatedSprite.play("open")
	
