extends Control

# Example notifications dictionary.
# You can expand this list with as many notifications as you need.
var notifications: Array[Dictionary] = [
	{
		"title": "The Public Has Turned Against You!",
		"description": "Your policies have alienated the population.",
		"options": [
			{"text": "Improve Relations", "effects": {"public_support": 20, "morality": 10}},
			{"text": "Use Force", "effects": {"public_support": -10, "corruption": 5}},
			{"text": "Hold a Rally", "effects": {"public_support": 15, "morality": 5}},
			{"text": "Ignore", "effects": {}}
		]
	},
	{
		"title": "Economic Collapse!",
		"description": "The economy is in shambles due to poor fiscal policies.",
		"options": [
			{"text": "Implement Austerity", "effects": {"economy": 15, "public_support": -20}},
			{"text": "Stimulus Package", "effects": {"economy": 10, "public_support": 10}},
			{"text": "Do Nothing", "effects": {}}
		]
	},
	{
		"title": "Corruption Scandal!",
		"description": "A major corruption scandal has been uncovered.",
		"options": [
			{"text": "Launch Anti-Corruption Campaign", "effects": {"corruption": -20, "public_support": 10}},
			{"text": "Cover It Up", "effects": {"corruption": 10, "public_support": -20}},
			{"text": "Resign", "effects": {"game_over": true, "reason": "Resigned amid scandal."}}
		]
	},
	{
		"title": "International Sanctions!",
		"description": "Foreign powers have imposed sanctions on your regime.",
		"options": [
			{"text": "Negotiate", "effects": {"foreign_relations": 15, "public_support": 5}},
			{"text": "Retaliate", "effects": {"public_support": -10, "corruption": 5}},
			{"text": "Do Nothing", "effects": {}}
		]
	},
	{
		"title": "Military Uprising!",
		"description": "The military is on the verge of a coup.",
		"options": [
			{"text": "Negotiate with Leaders", "effects": {"diplomacy": 10, "authority": 5}},
			{"text": "Deploy Forces", "effects": {"authority": 10, "public_support": -15}},
			{"text": "Abdicate", "effects": {"game_over": true, "reason": "Overthrown by the military."}}
		]
	}
]

# Node paths (adjust these to match your scene tree)
@onready var notification_panel: Panel = $NotificationPanel
@onready var title_label: Label = $NotificationPanel/TitleLabel
@onready var description_label: Label = $NotificationPanel/DescriptionLabel
@onready var options_container: VBoxContainer = $NotificationPanel/OptionsContainer
@onready var game_over_label: Label = $GameOverLabel

func _ready() -> void:
	# Hide panels at startup.
	notification_panel.visible = false
	game_over_label.visible = false

# Call this function to show a notification.
# notification_data should be a Dictionary with keys: "title", "description", "options" (an array of option dictionaries)
func show_notification(notification_data: Dictionary) -> void:
	notification_panel.visible = true
	game_over_label.visible = false
	
	# Set the title and description.
	title_label.text = notification_data.get("title", "Notification")
	description_label.text = notification_data.get("description", "")
	
	# Clear any existing option buttons.
	for child in options_container.get_children():
		child.queue_free()
	
	# Create buttons dynamically for each option.
	var options: Array = notification_data.get("options", [])
	for option in options:
		var btn: Button = Button.new()
		btn.text = option.get("text", "Option")
		# Connect the pressed signal to _on_option_pressed and pass the option dictionary as argument.
		btn.connect("pressed", self, "_on_option_pressed", [option])

		options_container.add_child(btn)

# This function is called when an option button is pressed.
func _on_option_pressed(option: Dictionary) -> void:
	# Process the effects for the option.
	var effects: Dictionary = option.get("effects", {})
	for stat in effects.keys():
		# If an effect includes game_over, handle it specially.
		if stat == "game_over" and effects[stat]:
			_show_game_over(option.get("reason", "No reason provided."))
		else:
			# Here, update your global simulation stats.
			# For example, if GlobalData.simulation.stats exists:
			if GlobalData.has("simulation") and GlobalData.simulation.has("stats") and GlobalData.simulation.stats.has(stat):
				GlobalData.simulation.stats[stat] += effects[stat]
			else:
				print("Stat '%s' not found in simulation." % stat)
	
	# Hide the notification panel after processing the option.
	notification_panel.visible = false

# Displays the Game Over screen with the provided reason.
func _show_game_over(reason: String) -> void:
	notification_panel.visible = false
	game_over_label.visible = true
	game_over_label.text = "Game Ended: " + reason

# --- Example usage ---
# To show one of your notifications, call the following from anywhere in your code:
# Notifications.show_notification(notifications[0])
