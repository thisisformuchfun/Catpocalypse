extends StaticBody3D
## Simple interactable object for testing interaction system

@export var interaction_text: String = "Press E to interact"
@export var use_highlight: bool = true

var player_nearby: bool = false

func _ready():
	# Add to interaction layer
	collision_layer = 2
	collision_mask = 0

func interact():
	print("Interacted with: ", name)
	# Add visual/audio feedback here
	_on_interact()

func _on_interact():
	# Override in derived classes
	# This is a test object, so just print
	print("Test object interacted!")

func highlight(enabled: bool):
	if not use_highlight:
		return

	# Simple highlight effect - change material emission
	for child in get_children():
		if child is MeshInstance3D:
			var material = child.get_surface_override_material(0)
			if material and material is StandardMaterial3D:
				if enabled:
					material.emission_enabled = true
					material.emission = Color(0.5, 0.5, 1.0)
					material.emission_energy = 0.5
				else:
					material.emission_enabled = false
