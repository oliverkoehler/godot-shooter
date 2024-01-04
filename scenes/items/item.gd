extends Area2D

@export var rotation_speed: int = 5
var available_options: Array = ['health', 'laser', 'grenade']
var type = available_options.pick_random()

var direction: Vector2 
var distance: int = randi_range(150, 250) 

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color("1a70e0") # blue
		$PointLight2D.color = Color("1a70e0")
		
	if type == 'grenade':
		$Sprite2D.modulate = Color("e22a4c") # red
		$PointLight2D.color = Color("e22a4c")
	
	if type == 'health':
		$Sprite2D.modulate = Color("309460") # green
		$PointLight2D.color = Color("309460")
		
	var target_position = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.25)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == 'health':
		Globals.health += 10
		
	if type == 'laser':
		Globals.laser_amount += 5
		
	if type == 'grenade':
		Globals.grenade_amount += 2
	queue_free()
