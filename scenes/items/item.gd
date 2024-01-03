extends Area2D

@export var rotation_speed: int = 5
var available_options: Array = ['laser', 'laser', 'laser', 'laser', 'grenade', 'grenade', 'health']
var type = available_options.pick_random()

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


func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(type)
	queue_free()
