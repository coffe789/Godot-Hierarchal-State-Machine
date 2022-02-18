extends KinematicBody2D

var velocity = Vector2.ZERO
var is_crouching = false
var air_jump_count = 0

func _ready():
	$SM.Target = self # Initialise machine
	$SM.connect("changed_state",self,"on_changed_state")

func _physics_process(delta):
	$SM.update(delta) # Run machine

func on_changed_state(previous,current_state):
	$StateLabel.text = current_state.name
	print(previous.name,"->",current_state.name)
	
