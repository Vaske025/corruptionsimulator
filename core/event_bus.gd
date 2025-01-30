# Autoload-safe event bus implementationclass_name EventBus
extends Node

# Signals
signal game_state_changed(new_state)
signal protest_spawned(protest_data)

# Static access pattern
static var instance: EventBusManager

func _enter_tree() -> void:
	instance = self

static func emit_game_state_changed(state):
	if instance:
		instance.emit_signal("game_state_changed", state)

static func emit_protest_spawned(data):
	if instance:
		instance.emit_signal("protest_spawned", data)
