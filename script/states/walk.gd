extends "res://script/states/GroundState.gd"

func _update(delta):
	._update(delta)
	do_movement()
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)
