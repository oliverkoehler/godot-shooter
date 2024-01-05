extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	$Timer.start()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body: Node):
	print(body)
	if "hit" in body:
		body.hit()
		queue_free()


func _on_timer_timeout():
	queue_free()
