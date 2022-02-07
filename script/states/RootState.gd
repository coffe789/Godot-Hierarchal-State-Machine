extends State
const GRAVITY = 9.8
const MOVE_SPEED = 10
const MAX_X_SPEED = 400
const MAX_FALL_SPEED = 500

# The root picks the default substate
func _choose_substate():
	if !conditions_lib.is_grounded():
		return $AirState
	return $GroundState


func get_input_direction():
	return (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

func clamp_move_speed():
	Target.velocity.x = clamp(Target.velocity.x,-MAX_X_SPEED,MAX_X_SPEED)
	Target.velocity.y = clamp(Target.velocity.y,-INF,MAX_FALL_SPEED)


func do_movement(drag):
	if get_input_direction():
		Target.velocity.x += get_input_direction() * 100
	else:
		Target.velocity.x *= drag
	clamp_move_speed()
