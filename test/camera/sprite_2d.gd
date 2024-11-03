extends Sprite2D

func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_down")):
		global_position.y += 10
	if (Input.is_action_just_pressed("ui_up")):
		global_position.y -= 10
