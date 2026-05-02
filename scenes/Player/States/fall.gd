extends AirStateBase

var use_coyote: bool = false

func enter(fromState: StateBase) -> void:
	use_coyote = (fromState != jump_state)
	if use_coyote:
		player.coyote_timer.start(player.coyote_time)

func exit(_toState: StateBase) -> void:
	player.jump_buffer_timer.stop()

func input(_event: InputEvent) -> void:
	if has_input_direction_changed():
		updateAnimationBlend()

	if Input.is_action_just_pressed("jump"):
		player.jump_buffer_timer.start(player.jump_buffer_time)

		if use_coyote and !player.coyote_timer.is_stopped():
			machine.travel(jump_state)

	elif Input.is_action_just_pressed("attack"):
		machine.travel(attack_state)

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.input_dir * player.speed, player.acceleration)
	
	if Input.is_action_pressed("down"):
		player.velocity.y += (player.fall_gravity * 1.5) * delta
	else:
		player.velocity.y += player.fall_gravity * delta
	
	player.velocity.y = min(player.velocity.y, player.max_fall_speed)
	player.move_and_slide()
	
	if player.is_on_floor():
		handle_landing()
