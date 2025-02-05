# systems/protest_manager.gd
extends Node

var protest_scene = preload("res://ui/scenes/protest.tscn")

func spawn_protest(location: Vector2, reason: String) -> void:
	if protest_scene:
		var new_protest = protest_scene.instantiate()
		if new_protest:
			new_protest.position = location
			new_protest.reason = reason
			add_child(new_protest)
		else:
			push_error("Failed to instantiate the protest scene.")
	else:
		push_error("Protest scene not loaded.")
