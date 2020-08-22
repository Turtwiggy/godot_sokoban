extends Area2D

onready var ray = $RayCast2D
var tile_size = 16
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
	#quit the app
	if event.is_action_pressed("ui_end"):
		get_tree().quit()

func move(dir):
	var dir_ray = inputs[dir] * tile_size
	ray.cast_to = dir_ray
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		print("player not collided")
		position += dir_ray
	else:
		print("player colliding!")
		var collider = ray.get_collider()
		if collider.is_in_group('box'):
			if collider.move(dir):
				position += dir_ray
