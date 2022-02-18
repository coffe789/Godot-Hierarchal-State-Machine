extends "res://script/states/JumpState.gd"

func _enter():
	._enter()
	Target.is_crouching = true

func _exit():
	Target.is_crouching = false
