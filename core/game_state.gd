# core/game_state.gd
extends Node
#class_name GameState

enum State { MAIN_MENU, CHARACTER_CREATION, GAME }
var current_state: State = State.MAIN_MENU

func transition_to(new_state: State):
	exit_state(current_state)
	current_state = new_state
	enter_state(new_state)

func enter_state(state: State):
	match state:
		State.MAIN_MENU:
			get_tree().change_scene_to_file("res://ui/scenes/MainMenu.tscn")
		State.CHARACTER_CREATION:
			get_tree().change_scene_to_file("res://ui/scenes/CharacterCreation.tscn")
		State.GAME:
			get_tree().change_scene_to_file("res://ui/scenes/World.tscn")

func exit_state(state: State):
	pass
