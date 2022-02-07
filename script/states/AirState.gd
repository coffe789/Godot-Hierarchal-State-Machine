extends "res://script/states/RootState.gd"
const AIR_DRAG = 0.97

func _choose_substate():
	return $fall

func _update(_delta):
	Target.velocity.y += GRAVITY
	do_movement(AIR_DRAG)

func _add_transitions():
	transitions.append(StateTransition.new(
		1,"toGround",FSM.get_node("RootState/GroundState"),funcref(conditions_lib,"is_grounded")))
