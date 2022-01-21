extends Area2D

func _on_fall_zone_body_entered(body):
	
	print(body)
	if body.name == "Player":
		get_tree().reload_current_scene()
