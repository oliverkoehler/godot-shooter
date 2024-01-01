extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready():
	$Timer.start()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body: Node):
	if body.name != "Player":
		queue_free()
	
	if "hit" in body:
		body.hit()


func _on_timer_timeout():
	queue_free()
