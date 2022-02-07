extends KinematicBody2D

var velocity = Vector2.ZERO

func _ready():
	$HFSM.target = self # Initialise machine

func _physics_process(delta):
	$HFSM.update(delta) # Run machine
