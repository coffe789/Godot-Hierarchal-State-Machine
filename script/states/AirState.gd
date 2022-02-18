extends "res://script/states/RootState.gd"
const AIR_DRAG = 0.97

func _choose_substate():
	return $FallState

func _update(_delta):
	Target.velocity.y += GRAVITY
	do_movement()
	do_drag(AIR_DRAG)

func _add_transitions():
	transitions.append(StateTransition.new(
		1,"toGround",SM.get_node("RootState/GroundState"),funcref(conditions_lib,"is_grounded")))
	transitions.append(StateTransition.new(
		0,"toFall",SM.get_node("RootState/AirState"),funcref(conditions_lib,"is_to_fall")))
