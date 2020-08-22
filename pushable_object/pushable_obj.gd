extends KinematicBody2D

onready var ray = $RayCast2D
var tile_size = 16
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_R:
		position = Vector2(7 * tile_size, 7 * tile_size)
		position = position.snapped(Vector2.ONE * tile_size)
		
func move(dir):
	var dir_ray = inputs[dir] * tile_size
	ray.cast_to = dir_ray
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		print("box not collided")
		position += dir_ray
		return true
	else:
		print("box colliding!")
		var collider = ray.get_collider()
		if collider.is_in_group('end_goal'):
			print("you hit the end goal!")
			position += dir_ray

		return false
