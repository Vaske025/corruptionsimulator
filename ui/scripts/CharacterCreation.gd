extends Control

var traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
var points: int = 10
var selected_attribute: String = ""

@onready var attributes = {
	"diplomacy": $VBoxContainer/HBoxContainer/DiplomacyButton,
	"propaganda": $VBoxContainer/HBoxContainer2/PropagandaButton,
	"authority": $VBoxContainer/HBoxContainer3/AuthorityButton
}

@onready var minus_attributes = {
	"diplomacy": $VBoxContainer/HBoxContainer/MinusDiplomacyButton,
	"propaganda": $VBoxContainer/HBoxContainer2/MinusPropagandaButton,
	"authority": $VBoxContainer/HBoxContainer3/MinusAuthorityButton
}

@onready var diplomacy_label = $VBoxContainer/HBoxContainer/DiplomacyLabel
@onready var propaganda_label = $VBoxContainer/HBoxContainer2/PropagandaLabel
@onready var authority_label = $VBoxContainer/HBoxContainer3/AuthorityLabel
@onready var points_label = $VBoxContainer/PointsLabel
@onready var start_button = $VBoxContainer/StartButton
@onready var reset_button = $VBoxContainer/ResetButton
@onready var error_label = $VBoxContainer/ErrorPanel/ErrorLabel
@onready var error_animation = $VBoxContainer/ErrorPanel/ErrorAnimation

func _ready():
	_update_ui()
	_setup_tooltips()

func _update_ui():
	if diplomacy_label:
		diplomacy_label.text = "Diplomacy: %d" % traits.diplomacy
	else:
		print("Diplomacy label is null")

	if propaganda_label:
		propaganda_label.text = "Propaganda: %d" % traits.propaganda
	else:
		print("Propaganda label is null")

	if authority_label:
		authority_label.text = "Authority: %d" % traits.authority
	else:
		print("Authority label is null")

	if points_label:
		points_label.text = "Points Remaining: %d" % points
	else:
		print("Points label is null")

	if start_button:
		start_button.disabled = points > 0
	else:
		print("Start button is null")

	if reset_button:
		reset_button.visible = points < 10
	else:
		print("Reset button is null")

	for attr in attributes:
		var btn = attributes[attr]
		if btn:
			btn.disabled = (points == 0)
		else:
			print("%s button is null" % attr)

	for attr in minus_attributes:
		var btn = minus_attributes[attr]
		if btn:
			btn.disabled = (traits[attr] == 0)
		else:
			print("%s minus button is null" % attr)

func _setup_tooltips():
	if attributes["diplomacy"]:
		attributes["diplomacy"].tooltip_text = "Affects negotiation outcomes and international relations"
	else:
		print("Diplomacy button is null")

	if attributes["propaganda"]:
		attributes["propaganda"].tooltip_text = "Influences public opinion and media control"
	else:
		print("Propaganda button is null")

	if attributes["authority"]:
		attributes["authority"].tooltip_text = "Determines military and police effectiveness"
	else:
		print("Authority button is null")

func _allocate_point(attribute: String):
	if points > 0:
		traits[attribute] += 1
		points -= 1
		_update_ui()
		_play_sound("res://sounds/click.wav")
	else:
		_shake_buttons()

func _deallocate_point(attribute: String):
	if traits[attribute] > 0:
		traits[attribute] -= 1
		points += 1
		_update_ui()
		_play_sound("res://sounds/click.wav")

func _on_diplomacy_button_pressed():
	_allocate_point("diplomacy")

func _on_propaganda_button_pressed():
	_allocate_point("propaganda")

func _on_authority_button_pressed():
	_allocate_point("authority")

func _on_minus_diplomacy_button_pressed():
	_deallocate_point("diplomacy")

func _on_minus_propaganda_button_pressed():
	_deallocate_point("propaganda")

func _on_minus_authority_button_pressed():
	_deallocate_point("authority")

func _on_reset_button_pressed():
	traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
	points = 10
	_update_ui()
	_play_sound("res://sounds/reset.wav")

func _shake_buttons():
	var tween = create_tween()
	for btn in attributes.values():
		if btn:
			tween.parallel().tween_property(btn, "position:x", btn.position.x + 5, 0.1)
			tween.parallel().tween_property(btn, "position:x", btn.position.x - 5, 0.1)
			tween.parallel().tween_property(btn, "position:x", btn.position.x, 0.1)
		else:
			print("Button is null")

func _play_sound(path):
	var sound = AudioStreamPlayer.new()
	sound.stream = load(path)
	add_child(sound)
	sound.play()
	await sound.finished
	sound.queue_free()


func _on_start__button_pressed():
	if points == 0:
		GlobalData.player_traits = traits.duplicate()
		GameStateManager.transition_to(GameStateManager.State.GAME)
	else:
		if error_label and error_animation:
			error_label.text = "Allocate all points before starting!"
			error_animation.play("error_flash")  # Reproduciraj animaciju
		else:
			print("Error: Missing ErrorLabel or ErrorAnimation")
func _show_error(message: String):
	if error_label and error_animation:
		error_label.text = message 
		error_animation.play("error_flash")  # Reproduciraj animaciju
	else:
		print("Error: Missing ErrorLabel or ErrorAnimation")
