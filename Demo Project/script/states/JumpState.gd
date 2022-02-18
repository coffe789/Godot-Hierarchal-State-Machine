extends "res://script/states/AirState.gd"
const JUMP_SPEED = 400

func _choose_substate():
	if Target.is_crouching:
		return $CrouchJump
	return $Jump

func _enter():
	Target.velocity.y = -JUMP_SPEED
	if !Target.is_on_floor():
		Target.air_jump_count -= 1

func _update(_delta):
	._update(_delta)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)
