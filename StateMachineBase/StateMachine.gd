class_name StateMachine extends Node

@export var state: StateBase
var lastState: StateBase = null

func _ready() -> void:
	assert(state != null, "StateMachine has no initial state assigned")
	travel(state)

func _input(event: InputEvent) -> void:
	state.input(event)
	
func _process(delta: float) -> void:
	state.process_update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func travel(newState: StateBase):
	if lastState:
		lastState = state 
		lastState.exit(newState)
	else:
		lastState = state
	
	state = newState
	state.enter(lastState)
