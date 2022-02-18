extends "res://script/states/GroundState.gd"

func _enter():
	._enter()
	Target.is_crouching = true

func _exit():
	Target.is_crouching = false

func _update(delta):
	._update(delta)
	# (Does not have x movement)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)
