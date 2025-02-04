# ui/scripts/World.gd
extends Node

# Variables for tracking time
var current_turn: int = 1
var turns_per_day: int = 10
var days_passed: int = 0

# References to global data
@onready var player_traits = GlobalData.player_traits
@onready var country_simulation = GlobalData.simulation

# References to UI elements
@onready var turn_label = $UI/VBoxContainer/TurnLabel
@onready var economy_label = $UI/VBoxContainer/EconomyLabel
@onready var public_support_label = $UI/VBoxContainer/PublicSupportLabel
@onready var morality_label = $UI/VBoxContainer/MoralityLabel  # New label for morality
@onready var next_turn_button = $UI/VBoxContainer/NextTurnButton

# References for notifications
@onready var notification_panel = $UI/NotificationPanel
@onready var notification_label = $UI/NotificationPanel/NotificationLabel
@onready var option_buttons = {
	"Option1": $UI/NotificationPanel/Option1Button as CustomButton,
	"Option2": $UI/NotificationPanel/Option2Button as CustomButton
}

# Initialization
func _ready():
	print("Game started!")
	_update_ui()
	notification_panel.visible = false  # Hide the notification panel

# Update the UI
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
	if morality_label:
		morality_label.text = "Morality: %d" % GlobalData.morality_score  # Display morality
	else:
		print("Morality label is null")

# Handle the next turn
func next_turn():
	current_turn += 1
	if current_turn > turns_per_day:
		days_passed += 1
		current_turn = 1
	_handle_daily_events()
	country_simulation._process(10)  # Simulate stats with a larger delta
	_update_ui()
	check_game_over()  # Check if the game is over

# Handle daily events
func _handle_daily_events():
	print("Handling daily events...")
	country_simulation._process(10)  # Simulate stats with a larger delta
	check_for_protests()

# Check for protests
func check_for_protests():
	var events = GlobalData.load_json("res://data/events.json")  # Use the global function
	if not events or not events.has("events"):
		print("Failed to load events.json or no events found.")
		return
	for event in events["events"]:
		var trigger_conditions_met = true
		for condition in event["trigger_conditions"]:
			if not evaluate_condition(condition):
				trigger_conditions_met = false
				break
		if trigger_conditions_met:
			print("Event triggered:", event["title"])  # Debug print
			spawn_protest(event)

# Evaluate conditions
func evaluate_condition(condition: String) -> bool:
	var parts = condition.split(" ")
	if parts.size() < 3:
		print("Invalid condition format:", condition)
		return false
	var stat = parts[0]
	var operator = parts[1]
	var value = int(parts[2])
	var stat_value = country_simulation.stats.get(stat, -1)  # Use .get to avoid crashes
	if stat_value == -1:
		print("Unknown stat:", stat)
		return false
	if operator == "<":
		return stat_value < value
	elif operator == ">":
		return stat_value > value
	elif operator == "=":
		return stat_value == value
	else:
		push_error("Unknown operator: " + operator)
		return false

# Spawn a protest
func spawn_protest(event: Dictionary):
	var protest_data = {
		"title": event["title"],
		"description": event["description"],
		"options": event["options"]
	}
	show_notification(protest_data)  # Show the notification

# Show a notification
func show_notification(data: Dictionary):
	if not notification_panel or not notification_label or not option_buttons["Option1"] or not option_buttons["Option2"]:
		print("Error: Notification UI elements are not properly set up.")
		return

	# Set the notification text
	if data.has("title") and data.has("description"):
		notification_label.text = data["title"] + "\n\n" + data["description"]
	else:
		notification_label.text = "The public is against you!"  # Fallback message
		print("Warning: Event data missing title or description.")

	# Set the option texts
	if data.has("options") and data["options"].size() >= 2:
		option_buttons["Option1"].text = data["options"][0].get("text", "Option 1")
		option_buttons["Option2"].text = data["options"][1].get("text", "Option 2")

		# Set the effects for each option
		if data["options"][0].has("effects"):
			option_buttons["Option1"].effects = data["options"][0]["effects"]
		if data["options"][1].has("effects"):
			option_buttons["Option2"].effects = data["options"][1]["effects"]
	else:
		print("Warning: Event data missing options.")

	# Show the notification panel
	notification_panel.visible = true

# Handle option button presses
func _on_option_1_button_pressed():
	if not option_buttons["Option1"]:
		print("Error: Option1 button is null")
		return
	apply_effects(option_buttons["Option1"].effects)
	notification_panel.visible = false  # Hide the notification panel

func _on_option_2_button_pressed():
	if not option_buttons["Option2"]:
		print("Error: Option2 button is null")
		return
	apply_effects(option_buttons["Option2"].effects)
	notification_panel.visible = false  # Hide the notification panel

# Apply effects from an option
func apply_effects(effects: Dictionary):
	var country_stats = GlobalData.simulation.stats
	for stat in effects:
		if stat in country_stats:
			country_stats[stat] += effects[stat]
		elif stat == "morality":
			GlobalData.update_morality(effects[stat])  # Update morality
		elif stat == "history":  # Add to game history
			GlobalData.game_history.append(effects[stat])
		else:
			print("Unknown effect key:", stat)
	_update_ui()  # Refresh UI after applying effects

# Check if the game is over
func check_game_over():
	if GlobalData.morality_score <= 0:
		show_notification({
			"title": "You Have Been Overthrown!",
			"description": "Your immoral actions have led to your downfall.",
			"options": [
				{"text": "Restart", "effects": {}},
				{"text": "Quit", "effects": {}}
			]
		})
	elif country_simulation.stats.public_support <= 10:
		show_notification({
			"title": "The Public Has Turned Against You!",
			"description": "Your policies have alienated the population.",
			"options": [
				{"text": "Improve Relations", "effects": {"public_support": +20, "morality": +10}},
				{"text": "Use Force", "effects": {"public_support": -10, "corruption": +5}}
			]
		})
	elif days_passed >= 100:
		show_notification({
			"title": "You Survived Your Term!",
			"description": "Congratulations on completing your presidency.",
			"options": [
				{"text": "Restart", "effects": {}},
				{"text": "Quit", "effects": {}}
			]
		})

# End the game
func _end_game(message: String):
	print(message)
	get_tree().change_scene_to_file("res://ui/scenes/MainMenu.tscn")

# Handle the "Next Turn" button press
func _on_next_turn_button_pressed():
	next_turn()
