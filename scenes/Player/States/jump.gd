extends AirStateBase

func enter(_fromState: StateBase) -> void:
	player.velocity.y = player.jump_velocity
	player.velocity.x *= 1.1
	
	if not Input.is_action_pressed("jump"):
		player.velocity.y *= 0.6

func exit(toState: StateBase) -> void:
	if toState != fall_state:
		player.jump_buffer_timer.stop()

func input(event: InputEvent) -> void:
	if has_input_direction_changed():
		updateAnimationBlend()

	if event.is_action_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.6

	if Input.is_action_just_pressed("jump"):
		player.jump_buffer_timer.start(player.jump_buffer_time)

	elif Input.is_action_just_pressed("attack"):
		machine.travel(attack_state)

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.input_dir * player.speed, player.acceleration * 0.3)
	player.velocity.y += player.jump_gravity * delta
	player.move_and_slide()

	if player.velocity.y >= 0:
		machine.travel(fall_state)
	elif player.is_on_floor():
		handle_landing()
