class_name StateBase extends Node

var machine: StateMachine

func _enter_tree() -> void:
	machine = get_parent()

func input(_event: InputEvent) -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_fromState: StateBase) -> void:
	pass

func exit(_toState: StateBase) -> void:
	pass
