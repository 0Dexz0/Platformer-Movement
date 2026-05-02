class_name PlayerStateBase extends StateBase

static var idle_state: StateBase
static var run_state: StateBase
static var jump_state: StateBase
static var fall_state: StateBase
static var fell_state: StateBase
static var attack_state: StateBase
static var animation_tree: AnimationTree
static var playback: AnimationNodeStateMachinePlayback
static var player: Player

static func updateAnimationBlend():
	animation_tree.set("parameters/Idle/blend_position", player.input_dir)
	animation_tree.set("parameters/Run/blend_position", player.input_dir)
	animation_tree.set("parameters/JumpStates/Jump/blend_position", player.input_dir)
	animation_tree.set("parameters/JumpStates/Fall/blend_position", player.input_dir)
	animation_tree.set("parameters/JumpStates/Fell_Once/blend_position", player.input_dir)
	animation_tree.set("parameters/JumpStates/AttackStates/Attack1/blend_position", player.input_dir)
	animation_tree.set("parameters/JumpStates/AttackStates/Attack2/blend_position", player.input_dir)
	animation_tree.set("parameters/AttackStates/Attack1/blend_position", player.input_dir)
	animation_tree.set("parameters/AttackStates/Attack2/blend_position", player.input_dir)
	player.last_input_dir = player.input_dir

static func has_input_direction_changed():
	return sign(player.input_dir) != 0 and sign(player.input_dir) != sign(player.last_input_dir)

func travel_to_ground_state():
	if player.input_dir == 0:
		machine.travel(idle_state)
	else:
		machine.travel(run_state)
