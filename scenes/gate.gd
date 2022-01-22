extends Node2D

export(NodePath) var b_camera
export(NodePath) var f_camera
export(NodePath) var player

var b_camera_obj : Camera2D
var f_camera_obj : Camera2D
var p_camera_obj : Camera2D

func _ready():
	
	var player_obj = get_node_or_null(player)
	
	if player_obj:
		p_camera_obj = player_obj.get_node_or_null('Camera2D')
		
	b_camera_obj = get_node_or_null(b_camera)	
	f_camera_obj = get_node_or_null(f_camera)

func _on_back_body_entered(_body):
	
	if b_camera_obj:
		b_camera_obj.make_current()
	elif p_camera_obj:
		p_camera_obj.make_current()

func _on_front_body_entered(_body):
	
	if f_camera_obj:
		f_camera_obj.make_current()
	elif p_camera_obj:
		p_camera_obj.make_current()
