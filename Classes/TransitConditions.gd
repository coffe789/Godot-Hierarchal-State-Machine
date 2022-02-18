# Transit Conditions
# Holds the functions which determine if a state transition can occur (true/false)
# These functions can be anywhere, but I find it convenient to put them all in 1 place
extends Node
class_name TransitConditions

onready var Target
onready var root_state
var SM
