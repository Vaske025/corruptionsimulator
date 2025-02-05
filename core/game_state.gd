# core/game_state.gd
extends Node

enum State { MAIN_MENU, CHARACTER_CREATION, GAME }
var current_state: State = State.MAIN_MENU

func transition_to(new_state: State) -> void:
	exit_state(current_state)
	current_state = new_state
	enter_state(new_state)
	# Use the autoload "EventBusManager" to emit the game state change signal.
	EventBusManager.emit_game_state_changed(new_state)

func enter_state(state: State) -> void:
	match state:
		State.MAIN_MENU:
			get_tree().change_scene_to_file("res://ui/scenes/MainMenu.tscn")
		State.CHARACTER_CREATION:
			get_tree().change_scene_to_file("res://ui/scenes/CharacterCreation.tscn")
		State.GAME:
			get_tree().change_scene_to_file("res://ui/scenes/World.tscn")

func exit_state(_state: State) -> void:
	# Any cleanup for leaving a state can go here.
	pass
