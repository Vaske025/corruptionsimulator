# systems/protest_manager.gd
extends Node

var protest_scene = preload("res://systems/protest.tscn")

func spawn_protest(location: Vector2, reason: String):
	var new_protest = protest_scene.instantiate()
	new_protest.position = location
	new_protest.reason = reason
	add_child(new_protest)
