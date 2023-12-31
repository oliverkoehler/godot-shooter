extends CharacterBody2D

signal player_fired_laser(pos, direction)
signal player_fired_grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 500
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())

	var player_direction = Vector2(get_global_mouse_position() - position).normalized()
	
	# laser shooting
	if Input.is_action_just_pressed("main_action") and can_laser:
		$GPUParticles2D.emitting = true
		var laser_markers: Array[Node] = $LaserStartPositions.get_children()
		var selected_marker = laser_markers.pick_random()
		can_laser = false
		$MainActionTimer.start()
		player_fired_laser.emit(selected_marker.global_position, player_direction)
		
	if Input.is_action_just_pressed("secondary_action") and can_grenade:
		var laser_markers: Array[Node] = $LaserStartPositions.get_children()
		var selected_marker = laser_markers.pick_random()
		can_grenade = false
		$SecondaryActionTimer.start()
		player_fired_grenade.emit(selected_marker.global_position, player_direction)


func _on_main_action_timer_timeout():
	can_laser = true


func _on_secondary_action_timer_timeout():
	can_grenade = true
