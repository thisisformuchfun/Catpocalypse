extends Control
## Debug HUD for monitoring game performance and state

@onready var fps_label = $MarginContainer/VBoxContainer/FPSLabel
@onready var player_pos_label = $MarginContainer/VBoxContainer/PlayerPosLabel
@onready var cat_count_label = $MarginContainer/VBoxContainer/CatCountLabel
@onready var cat_state_label = $MarginContainer/VBoxContainer/CatStateLabel

var player: CharacterBody3D = null
var cats: Array = []

func _ready():
	# Find player in scene
	await get_tree().process_frame
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _process(_delta):
	# Update FPS
	var fps = Engine.get_frames_per_second()
	fps_label.text = "FPS: %d" % fps

	# Color code FPS
	if fps >= 60:
		fps_label.modulate = Color.GREEN
	elif fps >= 30:
		fps_label.modulate = Color.YELLOW
	else:
		fps_label.modulate = Color.RED

	# Update player position
	if player:
		var pos = player.global_position
		player_pos_label.text = "Player: (%.1f, %.1f, %.1f)" % [pos.x, pos.y, pos.z]
	else:
		player_pos_label.text = "Player: Not found"

	# Update cat count and state
	cats = get_tree().get_nodes_in_group("cats")
	cat_count_label.text = "Cats: %d" % cats.size()

	if cats.size() > 0:
		var cat = cats[0]
		if cat.has_method("get_state_name"):
			cat_state_label.text = "Cat State: %s" % cat.get_state_name()
		else:
			cat_state_label.text = "Cat State: Active"
	else:
		cat_state_label.text = "Cat State: None"
