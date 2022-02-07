extends Node
class_name StateMachine
signal activate

onready var current_state = $RootState
export var history_size = 3
var target setget set_target
var state_history = []

# Machine starts once target is set
func set_target(value):
	assert(value)
	target = value
	initialise_states(self)
	emit_signal("activate")


# Sets required parameters for all states via recursion
func initialise_states(root):
	for child in root.get_children():
		if child is State:
			child.Target = target
			child.FSM = self
			child.conditions_lib = $TransitConditions
			child._add_transitions()
			child._blacklist_transitions()
			child.inherit_transitions()
			child.sort_transitions()
			
			initialise_states(child) # Recurse


func add_to_history(state:State):
	state_history.push_back(state)
	if state_history.size() > history_size:
		state_history.pop_front()


# TODO make it so you don't enter/exit states because of super-states
func change_state(new_state:State):
	if current_state != new_state:
		if new_state.is_leaf():
			add_to_history(current_state)
			print(new_state.name)
		current_state._exit()
		new_state._enter()
		current_state = new_state


# Change state to the previous state
func pop_state():
		current_state._exit()
		var new_state = state_history.pop_back()
		new_state._enter()
		current_state = new_state


# Periodically called by the owner/target of the machine,
# from either _process or _physics_process
func update(delta):
	if current_state.is_leaf():
		current_state._update(delta)
		current_state.try_transition()
	else:
		change_state(current_state._choose_substate())
		update(delta)
