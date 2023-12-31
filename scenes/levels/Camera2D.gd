extends Camera2D

@export var randomStrength: float = 30
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func apply_shake():
	shake_strength = randomStrength

func _process(delta):
	print(delta)

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func _on_timer_timeout():
	apply_shake()
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * 0.01)
		
		offset = randomOffset()
