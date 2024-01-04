extends LevelParent

@export var inside_level_scene: PackedScene

func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.3)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)


func _on_house_player_leave():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
