class_name Player extends CharacterBody2D

# -----------------------------------------------------------------------------
#  GROUPS OF EXPORTED VARIABLES (organized in the Inspector)
# -----------------------------------------------------------------------------

@export_group("Base movement")
@export var speed : float = 100.0

@export_group("Acceleration and Friction")
@export_range(0.0, 1.0) var acceleration : float = 0.25
@export_range(0.0, 1.0) var friction : float = 0.22

@export_group("Gravity")
@export var jump_gravity : float = 980.0  
@export var fall_gravity : float = 980.0   
@export var max_fall_speed : float = 500.0

@export_group("Jump and Coyote")
@export var jump_velocity : float = -253.015
@export var jump_buffer_time : float = 0.2
@export var coyote_time : float = 0.1

@export_group("Attack and Combo")
@export var attack_buffer_time : float = 0.06
@export var combo_window_time : float = 0.5
@export var current_combo_attack : int = 1

# -----------------------------------------------------------------------------
#  INTERNAL VARIABLES (NOT shown in the Inspector)
# -----------------------------------------------------------------------------
var input_dir : float = 0.0
var last_input_dir : float = 0.0

var is_attacking : bool = false

# Timers creados por código
var coyote_timer : Timer
var jump_buffer_timer : Timer

# Referencias a nodos
var animation_tree : AnimationTree

# -----------------------------------------------------------------------------
#  LIFE CYCLE FUNCTIONS
# -----------------------------------------------------------------------------
func _enter_tree() -> void:
	animation_tree = $AnimationTree
	
	# Configure static references for states
	PlayerStateBase.player = self
	PlayerStateBase.animation_tree = animation_tree
	PlayerStateBase.playback = animation_tree["parameters/playback"]
	
	# References to states (within StateMachine)
	PlayerStateBase.idle_state = $StateMachine/Idle
	PlayerStateBase.run_state = $StateMachine/Run
	PlayerStateBase.jump_state = $StateMachine/Jump
	PlayerStateBase.fall_state = $StateMachine/Fall
	PlayerStateBase.attack_state = $StateMachine/Attack
	
	# Create and configure shared timers between different states
	coyote_timer = Timer.new()
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	
	jump_buffer_timer = Timer.new()
	jump_buffer_timer.one_shot = true
	add_child(jump_buffer_timer)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_undo"): # Ctrl + Z
		Engine.time_scale = 0.1
		
	if event.is_action_pressed("ui_cancel"): # Escape
		Engine.time_scale = 1.0
