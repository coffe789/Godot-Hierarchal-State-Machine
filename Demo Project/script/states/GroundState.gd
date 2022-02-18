extends "res://script/states/RootState.gd"
const GROUND_DRAG = 0.8

func _choose_substate():
	if conditions_lib.is_to_crouch():
		return $Crouch
	if conditions_lib.is_to_walk():
		return $Walk
	return $Idle 


func _update(_delta):
	Target.velocity.y += GRAVITY
	do_drag(GROUND_DRAG)


func _add_transitions():
	transitions.append(StateTransition.new(
		2,"toJump",SM.get_node("RootState/AirState/JumpState"),funcref(conditions_lib,"is_to_jump")))
	transitions.append(StateTransition.new(
		1,"toAir",SM.get_node("RootState/AirState"),funcref(conditions_lib,"is_airborne")))
	transitions.append(StateTransition.new(
		0,"toGround",SM.get_node("RootState/GroundState"),funcref(conditions_lib,"is_grounded")))
