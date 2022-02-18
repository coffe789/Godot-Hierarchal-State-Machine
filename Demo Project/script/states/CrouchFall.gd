extends "res://script/states/FallState.gd"

func _enter():
	Target.is_crouching = true

func _exit():
	Target.is_crouching = false
