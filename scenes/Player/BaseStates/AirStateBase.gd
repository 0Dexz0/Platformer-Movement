class_name AirStateBase extends PlayerStateBase

func handle_landing():
	if !player.jump_buffer_timer.is_stopped():
		machine.travel(jump_state)
	else:
		travel_to_ground_state()
