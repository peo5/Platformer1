extends KinematicBody2D

const move_speed = 200
const jump_force = -80
const gravity = 40

var vel = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var move_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	vel.x = move_speed * move_dir

	if(Input.is_action_just_pressed("jump")):
		vel.y += jump_force
	
	vel.y += gravity*delta
	
	move_and_slide(vel)
