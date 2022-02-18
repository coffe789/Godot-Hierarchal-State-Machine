extends "res://script/states/RootState.gd"

func _choose_substate():
	return $FallState

func _update(_delta):
	Target.velocity.y += GRAVITY
	do_movement()
	do_drag(AIR_DRAG)

func _add_transitions():
	transitions.append(StateTransition.new(
		2,"toJump",SM.get_node("RootState/AirState/JumpState"),funcref(conditions_lib,"is_to_jump"),true))
	transitions.append(StateTransition.new(
		1,"toGround",SM.get_node("RootState/GroundState"),funcref(conditions_lib,"is_grounded")))
	transitions.append(StateTransition.new(
		0,"toFall",SM.get_node("RootState/AirState"),funcref(conditions_lib,"is_to_fall")))
