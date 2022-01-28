extends KinematicBody2D

const move_speed = 2000
const jump_force = -200
const gravity = 300
const idle_time = 1

onready var sprite = $Sprite
onready var animation = $AnimationPlayer
onready var timer = $Timer

var dir = 1
var idle = false
var vel = Vector2(0.0, 180.0)

func _physics_process(delta: float) -> void:
	
	vel.x = 0 if idle else move_speed * dir * delta
	
	if not is_on_floor():
		vel.y += gravity*delta
	
	vel = move_and_slide(vel, Vector2.UP)
	
	_patrol_process()
	
	_anim_process()

func _patrol_process():
	
	if vel.x == 0 and not idle:
		idle = true;
		timer.set_wait_time(idle_time)
		timer.start()

func _on_Timer_timeout():
	
	dir *= -1
	idle = false

func _anim_process():
	
	var state = "idle" if idle else "run";
	
	if animation.assigned_animation != state:
		animation.play(state);
		
	sprite.scale.x = -1 * dir

