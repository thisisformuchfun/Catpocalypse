extends Node
## Core Game Manager
## Handles game state, save/load, and global events

enum GameState {
	MAIN_MENU,
	MORNING_SEQUENCE,
	THE_NEWS,
	THE_SHIFT,
	GAMEPLAY,
	PAUSED,
	GAME_OVER
}

# Singleton pattern
static var instance: Node = null

# State
var current_state = GameState.MAIN_MENU
var player = null

# Game data
var current_level = 0
var score = 0

# Signals
signal state_changed(new_state)
signal player_died()
signal level_completed()

func _ready():
	if instance == null:
		instance = self
	else:
		queue_free()
		return

	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func change_state(new_state: GameState):
	var old_state = current_state
	current_state = new_state
	state_changed.emit(new_state)

	match new_state:
		GameState.PAUSED:
			get_tree().paused = true
		GameState.GAMEPLAY:
			if old_state == GameState.PAUSED:
				get_tree().paused = false
		GameState.GAME_OVER:
			_handle_game_over()

func toggle_pause():
	if current_state == GameState.PAUSED:
		change_state(GameState.GAMEPLAY)
	elif current_state == GameState.GAMEPLAY:
		change_state(GameState.PAUSED)

func start_new_game():
	current_level = 0
	score = 0
	change_state(GameState.MORNING_SEQUENCE)
	# TODO: Load first level

func load_game(save_data: Dictionary):
	# TODO: Implement save/load system
	pass

func save_game() -> Dictionary:
	# TODO: Implement save/load system
	return {
		"level": current_level,
		"score": score,
		"timestamp": Time.get_unix_time_from_system()
	}

func _handle_game_over():
	player_died.emit()
	# TODO: Show game over screen
