# Global.gd - Singleton for global game state management

extends Node

# Global variables
var simulation: CountrySimulation = CountrySimulation.new()  # Reference to the country simulation
var player_traits: Dictionary = {}  # Player-defined traits (e.g., diplomacy, propaganda, authority)
var game_history: Array = []  # Tracks significant events during gameplay
var morality_score: int = 50  # Initial morality value (neutral)

# Function to update morality
func update_morality(change: int):
	morality_score += change
	morality_score = clamp(morality_score, 0, 100)  # Limit morality to 0-100 range
	print("Morality updated: ", morality_score)
	emit_signal("morality_updated", morality_score)  # Notify listeners of morality change

# Signal for morality updates
signal morality_updated(new_score: int)

# Global function to load JSON files
static func load_json(path: String) -> Dictionary:
	var json_result: Dictionary = {}  # Default empty dictionary if loading fails
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		var json = JSON.new()  # Create an instance of JSON
		var err = json.parse(json_string)  # Parse JSON and capture errors
		if err == OK:
			json_result = json.get_data()  # Get parsed data if successful
		else:
			push_error("Failed to parse JSON from file: " + path)
	else:
		push_error("File does not exist: " + path)
	return json_result  # Return the parsed JSON or an empty dictionary

# Save game state to a file
func save_game(save_path: String):
	var save_data = {
		"player_traits": player_traits.duplicate(),
		"game_history": game_history.duplicate(),
		"morality_score": morality_score,
		"simulation_stats": simulation.stats.duplicate()
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(save_data, true)  # Store with compression
		file.close()
	else:
		push_error("Failed to save game: Unable to open file at " + save_path)

# Load game state from a file
func load_game(load_path: String) -> bool:
	if not FileAccess.file_exists(load_path):
		print("Error: Save file not found at " + load_path)
		return false

	var file = FileAccess.open(load_path, FileAccess.READ)
	if file:
		var save_data = file.get_var(true)  # Read with compression
		file.close()

		player_traits = save_data.get("player_traits", {})
		game_history = save_data.get("game_history", [])
		morality_score = save_data.get("morality_score", 50)
		simulation.stats = save_data.get("simulation_stats", {})

		print("Game loaded successfully!")
		return true
	else:
		push_error("Failed to load game: Unable to open file at " + load_path)
		return false

# Reset game state
func reset_game():
	player_traits = {}
	game_history = []
	morality_score = 50
	simulation = CountrySimulation.new()
	print("Game state reset.")
