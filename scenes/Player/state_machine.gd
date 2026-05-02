extends StateMachine

var player: Player

func _enter_tree() -> void:
	player = self.owner

func _process(_delta: float) -> void:
	set_process(false)

func _input(event: InputEvent) -> void:
	player.input_dir = Input.get_axis("left", "right")
	state.input(event)
