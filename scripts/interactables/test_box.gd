extends Area3D
## Test interactable box for verifying interaction system

var interaction_count = 0

func interact():
	interaction_count += 1
	print("Test box interacted! Count: ", interaction_count)

	# Visual feedback - scale pulse
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3(1.2, 1.2, 1.2), 0.1)
	tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.1)
