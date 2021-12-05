extends CanvasLayer

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("toggle_snow"):
		$Snow.emitting = !$Snow.emitting
	elif event.is_action_pressed("toggle_fog"):
		$fog.visible = !$fog.visible
