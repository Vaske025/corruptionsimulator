# systems/save_system.gd
class_name SaveSystem
extends Node

const SAVE_PATH = "user://savegame.save"

func save_game():
	var save_data = {
		"stats": Global.country_stats,
		"policies": Global.policies,
		"history": Global.game_history
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(save_data)

func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		return file.get_var()
	return null
