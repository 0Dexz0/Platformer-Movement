extends PlayerStateBase

func input(event: InputEvent) -> void:
	if has_input_direction_changed():
		updateAnimationBlend()
	
	if event.is_action_pressed("attack"):
		machine.travel(attack_state)
	
	elif event.is_action_pressed("jump") and player.is_on_floor():
		machine.travel(jump_state)
	
	elif player.input_dir != 0.0:
		machine.travel(run_state)

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
	player.velocity.y += player.fall_gravity * delta
	player.move_and_slide()

	if !player.is_on_floor():
		machine.travel(fall_state)
