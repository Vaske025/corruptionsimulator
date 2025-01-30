extends Control

func _on_start_game_button_pressed() :
	GameStateManager.transition_to(GameStateManager.State.CHARACTER_CREATION)


func _on_exit_button_pressed() :
	get_tree().quit()


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/scenes/OptionsMenu.tscn")


func _on_load_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/scenes/World.tscn")
