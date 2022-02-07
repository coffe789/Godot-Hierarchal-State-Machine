extends "res://script/states/RootState.gd"
const GROUND_DRAG = 0.8

func _choose_substate():
	if conditions_lib.is_to_walk():
		return $walk
	return $idle 


func _update(_delta):
	Target.velocity.y += GRAVITY
	do_movement(GROUND_DRAG)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)


func _add_transitions():
	transitions.append(StateTransition.new(
		2,"toJump",FSM.get_node("RootState/AirState/jump"),funcref(conditions_lib,"is_to_jump")))
	transitions.append(StateTransition.new(
		1,"toAir",FSM.get_node("RootState/AirState"),funcref(conditions_lib,"is_airborne")))
	transitions.append(StateTransition.new(
		0,"toGround",FSM.get_node("RootState/GroundState"),funcref(conditions_lib,"is_grounded")))
