extends Enemy

func _ready():
	$AnimatedSprite.play("moving")
	
func _on_HitBox_body_entered(body):
	if body is SnowBall:
		var explosion = explosion_scene.instance()
		explosion.position = position
		get_tree().current_scene.add_child(explosion)
		explosion.emitting = true
		die()
	
