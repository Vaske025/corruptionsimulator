extends Node

# Global variables
var simulation = CountrySimulation.new()
var player_traits = {}
var game_history = []
var morality_score: int = 50  # Initial morality value (neutral)

# Function to update morality
func update_morality(change: int):
	morality_score += change
	morality_score = clamp(morality_score, 0, 100)  # Limit to 0-100
	print("Morality updated: ", morality_score)

# Global function to load JSON files
static func load_json(path: String) -> Dictionary:
	var json_result = {}  # Default empty dictionary if loading fails
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
