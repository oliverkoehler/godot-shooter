extends RigidBody2D

@export var speed = 1500

func explode():
	$AnimationPlayer.play("Explosion")
