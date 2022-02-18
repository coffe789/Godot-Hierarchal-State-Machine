extends "res://script/states/AirState.gd"

func _choose_substate():
	if Target.is_crouching:
		return $CrouchFall
	return $Fall

func _update(_delta):
	._update(_delta)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)
