extends KinematicBody2D

const move_speed = 4000
const jump_force = -200
const gravity = 300
const knockback_force = 100

onready var sprite = $Sprite
onready var animation = $AnimationPlayer

var vel = Vector2(0.0, 180.0)
var dir = 0

var health = 3
var hurt = false

func _physics_process(delta: float) -> void:
	
	_input_process(delta)
	
	if not is_on_floor():
		vel.y += gravity*delta
	
	vel = move_and_slide(vel, Vector2.UP)
	
	_anim_process()

func _input_process(delta: float) -> void:
	
	if not hurt:
		dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		vel.x = move_speed * dir * delta
	
	if dir != 0:
		sprite.scale.x = dir
	
	if vel.y == 0 and Input.is_action_just_pressed("jump"):
		vel.y = jump_force

func _anim_process():
	
	var state = "idle"
	
	if hurt:
		state = "hit"
	elif vel.y != 0:
		state = "jump" if vel.y < 0 else "fall"
	elif vel.x != 0:
		state = "run"
	
	if animation.assigned_animation != state:
		animation.play(state);

func _receive_damage():
	hurt = false
	health -= 1
	if health < 1:
		queue_free()
		get_tree().reload_current_scene()

func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == "hit":
		_receive_damage()

func _on_HurtArea2D_body_entered(body):
	
	if not hurt:
		hurt = true
		dir = -1 if body.position.x < position.x else 1
		vel.x = -1 * dir * knockback_force
