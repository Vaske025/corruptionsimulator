extends Node

# Declare member variables
var current_turn: int = 1
var turns_per_day: int = 10
var days_passed: int = 0

# Reference to global data and country simulation using 'onready'
@onready var player_traits = GlobalData.player_traits
@onready var country_simulation = GlobalData.simulation

# UI references
@onready var turn_label = $UI/VBoxContainer/TurnLabel
@onready var economy_label = $UI/VBoxContainer/EconomyLabel
@onready var public_support_label = $UI/VBoxContainer/PublicSupportLabel
@onready var next_turn_button = $UI/VBoxContainer/NextTurnButton

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize game state
	print("Game started!")
	_update_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Placeholder for time passing logic
	if Input.is_action_just_pressed("next_turn") or next_turn_button.is_pressed():
		_next_turn()

func _update_ui():
	if turn_label:
		turn_label.text = "Turn: %d | Day: %d" % [current_turn, days_passed]
	else:
		print("Turn label is null")

	if economy_label:
		economy_label.text = "Economy: %d" % country_simulation.stats.economy
	else:
		print("Economy label is null")

	if public_support_label:
		public_support_label.text = "Public Support: %d" % country_simulation.stats.public_support
	else:
		print("Public support label is null")

func _next_turn():
	current_turn += 1
	if current_turn > turns_per_day:
		days_passed += 1
		current_turn = 1
	_handle_daily_events()
	_update_ui()

func _handle_daily_events():
	# Placeholder for handling daily events
	print("Handling daily events...")
	# Simulate country stats based on player traits
	country_simulation._process(1) # Assuming delta is 1 for simplicity
	# Check for protests or other events
	check_for_protests()

func check_for_protests():
	# Load the events JSON file
	var events = load_json("res://data/events.json")
	if not events:
		print("Failed to load events.json")
		return
	
	# Iterate over the events and check conditions
	for event in events["events"]:
		var trigger_conditions_met = true
		for condition in event["trigger_conditions"]:
			if not evaluate_condition(condition):
				trigger_conditions_met = false
				break
		if trigger_conditions_met:
			spawn_protest(event)

func evaluate_condition(condition: String) -> bool:
	# Simple evaluation of conditions like "economy < 30"
	var parts = condition.split(" ")
	var stat = parts[0]
	var operator = parts[1]
	var value = int(parts[2])
	
	var stat_value = country_simulation.stats[stat]
	
	if operator == "<":
		return stat_value < value
	elif operator == ">":
		return stat_value > value
	elif operator == "=":
		return stat_value == value
	else:
		push_error("Unknown operator: " + operator)
		return false

func spawn_protest(event: Dictionary):
	# Example: Spawn a protest based on the event data
	var protest_data = {
		"title": event["title"],
		"description": event["description"],
		"options": event["options"]
	}
	EventBusManager.emit_protest_spawned(protest_data)

func load_json(path: String) -> Dictionary:
	var json_result = null
	var file = File.new()  # Create a new File instance
	if file.file_exists(path):
		file.open(path, File.READ)
		var json_string = file.get_as_text()
		file.close()
		json_result = parse_json(json_string)
		if not json_result:
			push_error("Failed to parse JSON from file: " + path)
	else:
		push_error("File does not exist: " + path)
	return json_result if json_result != null else {}
