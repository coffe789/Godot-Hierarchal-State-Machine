extends TransitConditions
# A library of functions that can be used to determine the result of state transitions

func is_grounded():
	return Target.is_on_floor()

func is_airborne():
	return !Target.is_on_floor()

func is_to_crouch():
	return is_grounded() && Input.is_action_pressed("ui_down")

func is_to_idle():
	return is_grounded() && get_input_direction() == 0

func is_to_walk():
	return is_grounded() && get_input_direction() != 0

func is_to_fall():
	return Target.velocity.y >= 0

func is_to_jump():
	return Input.is_action_just_pressed("ui_accept") && (is_grounded() || Target.air_jump_count > 0)

# Utility only functions: #
#-------------------------#
func get_input_direction():
	return (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
