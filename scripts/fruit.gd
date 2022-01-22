extends Area2D

onready var animation = $AnimationPlayer

func _on_Apple_body_entered(body):
	if body.name == "Player":
		collect()

func collect():
	animation.play("collect")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "collect":
		queue_free()
