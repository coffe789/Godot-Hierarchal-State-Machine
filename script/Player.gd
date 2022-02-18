extends KinematicBody2D

var velocity = Vector2.ZERO
var is_crouching = false

func _ready():
	$HFSM.target = self # Initialise machine
	$HFSM.connect("changed_state",self,"on_changed_state")

func _physics_process(delta):
	$HFSM.update(delta) # Run machine

func on_changed_state(_previous,current_state):
	$StateLabel.text = current_state.name
