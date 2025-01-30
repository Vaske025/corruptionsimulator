# core/event_bus.gd
class_name EventBus
extends Node

signal game_state_changed(new_state)
signal protest_spawned(protest_data)
