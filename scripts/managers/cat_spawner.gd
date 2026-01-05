extends Node3D
## Manages cat spawning in the level

@export var cat_scene: PackedScene
@export var spawn_interval: float = 5.0
@export var max_cats: int = 10

var spawn_points: Array[Marker3D] = []
var spawn_timer: float = 0.0

func _ready():
	# Find all spawn points in the scene
	_find_spawn_points(get_parent())

	if spawn_points.size() == 0:
		push_warning("CatSpawner: No spawn points found!")

	# Load cat scene if not set
	if not cat_scene:
		cat_scene = load("res://scenes/cat.tscn")

func _find_spawn_points(node: Node):
	if node is Marker3D and node.is_in_group("cat_spawn"):
		spawn_points.append(node)

	for child in node.get_children():
		_find_spawn_points(child)

func _process(delta):
	spawn_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		_try_spawn_cat()

func _try_spawn_cat():
	var current_cats = get_tree().get_nodes_in_group("cats")

	if current_cats.size() >= max_cats:
		return

	if spawn_points.size() == 0:
		return

	# Pick a random spawn point
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	spawn_cat_at(spawn_point.global_position)

func spawn_cat_at(position: Vector3):
	if not cat_scene:
		push_error("CatSpawner: No cat scene to spawn!")
		return

	var cat = cat_scene.instantiate()
	get_parent().add_child(cat)
	cat.global_position = position

	return cat
