extends State
const GRAVITY = 9.8
const MOVE_SPEED = 10
const MAX_X_SPEED = 400
const MAX_FALL_SPEED = 500
const MAX_AIR_JUMPS = 1
const GROUND_DRAG = 0.8
const AIR_DRAG = 0.97

# The root picks the default substate
func _choose_substate():
	if !conditions_lib.is_grounded():
		return $AirState
	return $GroundState

# Functions available to all states: #
#------------------------------------#
func get_input_direction():
	return (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

func clamp_move_speed():
	Target.velocity.x = clamp(Target.velocity.x,-MAX_X_SPEED,MAX_X_SPEED)
	Target.velocity.y = clamp(Target.velocity.y,-INF,MAX_FALL_SPEED)

func do_movement():
	if get_input_direction():
		Target.velocity.x += get_input_direction() * 100
	clamp_move_speed()

func do_drag(drag):
	Target.velocity.x *= drag
