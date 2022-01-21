extends KinematicBody2D

const sscale = 20
const move_speed = 250 * sscale
const jump_force = -8 * sscale
const gravity = 10 * sscale

onready var sprite = $Sprite
onready var animation = $AnimationPlayer

var vel = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	_input_process(delta)
	
	if not is_on_floor():
		vel.y += gravity*delta
	
	vel = move_and_slide(vel, Vector2.UP)
	
	_anim_process()

func _input_process(delta: float) -> void:
	
	var move_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	vel.x = move_speed * move_dir * delta
	
	if move_dir != 0:
		sprite.scale.x = move_dir
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		vel.y = jump_force

# TODO: animation glitches when player moves into a wall

func _anim_process():
	
	var state = "idle"
	
	if is_on_floor():
		state = "idle" if vel.x == 0 else "run"
	else:
		state = "jump" if vel.y < 0 else "fall"
	
	if animation.assigned_animation != state:
		animation.play(state);
