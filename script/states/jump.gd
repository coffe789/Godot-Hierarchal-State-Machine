extends "res://script/states/AirState.gd"
const JUMP_SPEED = 400

func _enter():
	Target.velocity.y -= JUMP_SPEED

func _update(_delta):
	get_parent()._update(_delta)
	Target.velocity = Target.move_and_slide(Target.velocity,Vector2.UP)

func _add_transitions():
	transitions.append(StateTransition.new(
		0,"toFall",FSM.get_node("RootState/AirState"),funcref(conditions_lib,"is_to_fall")))
