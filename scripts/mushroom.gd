extends KinematicBody2D

const move_speed = 2000
const jump_force = -200
const gravity = 300
const idle_time = 1

onready var sprite = $Sprite
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var ray = $RayCast2D

var dir = -1
var idle = false
var vel = Vector2(0.0, 180.0)

var hit = false
var health = 1

func _physics_process(delta: float) -> void:
	
	vel.x = 0 if idle else move_speed * dir * delta
	
	if not is_on_floor():
		vel.y += gravity*delta
	
	vel = move_and_slide(vel, Vector2.UP)
	
	_patrol_process()
	
	_anim_process()

func _patrol_process():
	
	if not idle and ray.is_colliding():
		idle = true;
		timer.start(idle_time)

func _on_Timer_timeout():
	
	dir *= -1
	sprite.scale.x *= -1
	ray.cast_to *= -1
	idle = false

func _anim_process():
	
	var state = "idle" if idle else "run";
	
	if hit:
		state = "hit";
	
	if animation.assigned_animation != state:
		animation.play(state);
		
func _receive_damage():
	
	hit = false;
	health -= 1;
	if health < 1:
		queue_free();
	

func _on_HitArea2D_body_entered(body):
	if not hit:
		hit = true
	body.vel.y = -150
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		_receive_damage()
