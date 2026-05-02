extends PlayerStateBase

var combo_window_timer: Timer 
var attack_buffer_timer: Timer  

func _ready() -> void:
	combo_window_timer = Timer.new()
	combo_window_timer.one_shot = true
	add_child(combo_window_timer)
	combo_window_timer.timeout.connect(_on_combo_window_timeout)

	attack_buffer_timer = Timer.new()
	attack_buffer_timer.one_shot = true
	add_child(attack_buffer_timer)
	attack_buffer_timer.timeout.connect(_on_buffer_timeout)

func enter(_fromState: StateBase) -> void:
	combo_window_timer.stop()
	attack_buffer_timer.stop()

	player.is_attacking = true
	player.velocity.y *= 0.5
	
	if !player.is_on_floor():
		player.velocity.x *= 1.5

func exit(_toState: StateBase) -> void:
	player.is_attacking = false
	attack_buffer_timer.stop()
	combo_window_timer.start(player.combo_window_time)

func input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack_buffer_timer.stop()
		player.is_attacking = true

	if event.is_action_released("attack"):
		attack_buffer_timer.start(player.attack_buffer_time)

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
	player.velocity.y += player.jump_gravity * delta
	player.move_and_slide()

func when_animation_end():
	player.current_combo_attack = 3 - player.current_combo_attack

	if !player.is_attacking:
		travel_to_ground_state()
	elif !Input.is_action_pressed("attack"):
		attack_buffer_timer.stop()
		player.is_attacking = false

func _on_buffer_timeout() -> void:
	player.is_attacking = false

func _on_combo_window_timeout() -> void:
	player.current_combo_attack  = 1
