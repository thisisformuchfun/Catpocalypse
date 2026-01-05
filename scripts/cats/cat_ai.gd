extends CharacterBody3D
## Cat AI behavior controller
## Implements the Cat AI State Machine from the architecture design

enum CatState {
	IDLE,
	CUTE,
	CURIOUS,
	HUNT,
	STALK,
	ATTACK,
	CONVERT
}

# AI Parameters
const WALK_SPEED = 2.0
const RUN_SPEED = 5.0
const DETECTION_RANGE = 10.0
const ATTACK_RANGE = 1.5

# State
var current_state = CatState.IDLE
var target_player = null
var state_timer = 0.0

# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var navigation_agent = $NavigationAgent3D
@onready var animation_player = $AnimationPlayer

func _ready():
	_change_state(CatState.IDLE)

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	state_timer += delta
	_update_state(delta)

	move_and_slide()

func _update_state(delta):
	match current_state:
		CatState.IDLE:
			_state_idle(delta)
		CatState.CUTE:
			_state_cute(delta)
		CatState.CURIOUS:
			_state_curious(delta)
		CatState.HUNT:
			_state_hunt(delta)
		CatState.STALK:
			_state_stalk(delta)
		CatState.ATTACK:
			_state_attack(delta)
		CatState.CONVERT:
			_state_convert(delta)

func _state_idle(delta):
	# Periodically check for player
	if state_timer > 1.0:
		_detect_player()
		state_timer = 0.0

func _state_cute(delta):
	# Display affectionate behavior
	# TODO: Play cute animations, purr sounds
	if state_timer > 3.0:
		_change_state(CatState.CURIOUS)

func _state_curious(delta):
	# Wander and explore
	# TODO: Implement wandering behavior
	if _can_see_player():
		_change_state(CatState.HUNT)

func _state_hunt(delta):
	# Begin hunting the player
	if target_player:
		var distance = global_position.distance_to(target_player.global_position)
		if distance < ATTACK_RANGE * 2:
			_change_state(CatState.STALK)
		else:
			_move_toward_player(RUN_SPEED)

func _state_stalk(delta):
	# Slow approach before attack
	if target_player:
		var distance = global_position.distance_to(target_player.global_position)
		if distance < ATTACK_RANGE:
			_change_state(CatState.ATTACK)
		else:
			_move_toward_player(WALK_SPEED)

func _state_attack(delta):
	# Attack the player
	# One lick = conversion
	if target_player and global_position.distance_to(target_player.global_position) < ATTACK_RANGE:
		# TODO: Play attack animation
		_change_state(CatState.CONVERT)

func _state_convert(delta):
	# Convert player to cat ally
	# TODO: Trigger game over or conversion sequence
	pass

func _change_state(new_state: CatState):
	current_state = new_state
	state_timer = 0.0
	# TODO: Update animations based on state

func get_state_name() -> String:
	match current_state:
		CatState.IDLE:
			return "IDLE"
		CatState.CUTE:
			return "CUTE"
		CatState.CURIOUS:
			return "CURIOUS"
		CatState.HUNT:
			return "HUNT"
		CatState.STALK:
			return "STALK"
		CatState.ATTACK:
			return "ATTACK"
		CatState.CONVERT:
			return "CONVERT"
	return "UNKNOWN"

func _detect_player():
	# Simple detection - find player in scene
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target_player = players[0]
		if _can_see_player():
			_change_state(CatState.HUNT)

func _can_see_player() -> bool:
	if not target_player:
		return false

	var distance = global_position.distance_to(target_player.global_position)
	return distance < DETECTION_RANGE

func _move_toward_player(speed: float):
	if not target_player:
		return

	# Use NavigationAgent3D for pathfinding
	navigation_agent.target_position = target_player.global_position

	if navigation_agent.is_navigation_finished():
		return

	var next_position = navigation_agent.get_next_path_position()
	var direction = (next_position - global_position).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Rotate to face movement direction
	if direction.length() > 0.01:
		var target_rotation = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, 0.1)
