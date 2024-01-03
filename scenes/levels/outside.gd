extends LevelParent

@export var inside_level_scene: PackedScene

func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.3)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
