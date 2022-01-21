extends KinematicBody2D

const sscale = 20
const move_speed = 250 * sscale
const jump_force = -8 * sscale
const gravity = 10 * sscale

var vel = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var move_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	vel.x = move_speed * move_dir * delta
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			vel.y = jump_force
	else:
		vel.y += gravity*delta
	
	move_and_slide(vel, Vector2.UP)
