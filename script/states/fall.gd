extends "res://script/states/AirState.gd"

func _update(_delta):
	get_parent()._update(_delta)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)
