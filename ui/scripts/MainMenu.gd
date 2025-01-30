extends Control

func _on_StartGameButton_pressed():
	get_tree().change_scene_to_file("res://ui/scenes/CharacterCreation.tscn")

func _on_load_game_pressed():
	# Учитај сачувану игру (ово ћеш имплементирати касније)
	get_tree().change_scene_to_file("res://systems/World.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://ui/scenes/OptionsMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
