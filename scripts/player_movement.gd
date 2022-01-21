extends KinematicBody2D

const move_speed = 4000
const jump_force = -200
const gravity = 300

onready var sprite = $Sprite
onready var animation = $AnimationPlayer

var vel = Vector2(0.0, 180.0)

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
	
	if vel.y == 0 and Input.is_action_just_pressed("jump"):
		vel.y = jump_force

func _anim_process():
	
	var state = "idle"
	
	if vel.y != 0:
		state = "jump" if vel.y < 0 else "fall"
	elif vel.x != 0:
		state = "run"
	
	if animation.assigned_animation != state:
		animation.play(state);
