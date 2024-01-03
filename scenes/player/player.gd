extends CharacterBody2D

signal player_fired_laser(pos, direction)
signal player_fired_grenade(pos, direction)
signal update_stats

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())

	var player_direction = Vector2(get_global_mouse_position() - position).normalized()
		
	# laser shooting
	if Input.is_action_just_pressed("main_action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers: Array[Node] = $LaserStartPositions.get_children()
		var selected_marker = laser_markers.pick_random()
		can_laser = false
		$MainActionTimer.start()
		player_fired_laser.emit(selected_marker.global_position, player_direction)
		
	if Input.is_action_just_pressed("secondary_action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var laser_markers: Array[Node] = $LaserStartPositions.get_children()
		var selected_marker = laser_markers.pick_random()
		can_grenade = false
		$SecondaryActionTimer.start()
		player_fired_grenade.emit(selected_marker.global_position, player_direction)


func _on_main_action_timer_timeout():
	can_laser = true


func _on_secondary_action_timer_timeout():
	can_grenade = true
	
	
func add_item(type: String) -> void:
	if type == 'laser':
		Globals.laser_amount += 5
		
	if type == 'grenade':
		Globals.grenade_amount += 2
		
	update_stats.emit()
