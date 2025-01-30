extends Node

func _ready():
	# Ово је прва сцена која се учитава
	get_tree().change_scene_to_file("res://ui/scenes/MainMenu.tscn")
