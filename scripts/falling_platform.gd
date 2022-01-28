extends KinematicBody2D

const gravity = 300
const fall_limit = 10000
const delay_time = 0.5
const shake_time = 1
const restart_time = 5

onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var collision = $CollisionShape2D

var shaking = false 
var falling = false
var triggered = false

var vel = Vector2.ZERO
var initial_position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	if falling:
		vel.y += gravity*delta
		vel = move_and_slide(vel)

func _on_Timer_timeout():
	
	if falling:
		animation.play("on")
		position = initial_position
		falling = false
		shaking = false
		triggered = false
		collision.disabled = false
		vel.y = 0;
	elif shaking:
		animation.play("off")
		falling = true
		initial_position = position
		collision.disabled = true
		timer.start(restart_time)
	else:
		animation.play("shaking")
		shaking = true
		timer.start(shake_time)

func _on_TriggerArea2D_body_entered(body):
	if not triggered and body.name == "Player" and body.position.y < position.y:
		triggered = true
		timer.start(delay_time)
