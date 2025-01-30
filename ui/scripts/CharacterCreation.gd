extends Control

var traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
var points: int = 10
var selected_attribute: String = ""

@onready var attributes = {
	"diplomacy": %DiplomacyButton,
	"propaganda": %PropagandaButton,
	"authority": %AuthorityButton
}

func _ready():
	_update_ui()
	_setup_tooltips()

# Promeniti % referencie na pun put do čvorova
@onready var diplomacy_label = $VBoxContainer/HBoxContainer/DiplomacyLabel
@onready var propaganda_label = $VBoxContainer/HBoxContainer2/PropagandaLabel
@onready var authority_label = $VBoxContainer/HBoxContainer3/AuthorityLabel
@onready var points_label = $VBoxContainer/PointsLabel
@onready var start_button = $VBoxContainer/StartButton

func _update_ui():
	diplomacy_label.text = "Diplomacy: %d" % traits.diplomacy
	propaganda_label.text = "Propaganda: %d" % traits.propaganda
	authority_label.text = "Authority: %d" % traits.authority
	points_label.text = "Points Remaining: %d" % points
	
	%StartButton.disabled = points > 0
	%ResetButton.visible = points < 10
	
	for attr in attributes:
		attributes[attr].disabled = (points == 0)

func _setup_tooltips():
	%DiplomacyButton.tooltip_text = "Affects negotiation outcomes and international relations"
	%PropagandaButton.tooltip_text = "Influences public opinion and media control"
	%AuthorityButton.tooltip_text = "Determines military and police effectiveness"

func _allocate_point(attribute: String):
	if points > 0:
		traits[attribute] += 1
		points -= 1
		_update_ui()
		_play_sound("res://sounds/click.wav")
	else:
		_shake_buttons()

func _on_diplomacy_button_pressed():
	_allocate_point("diplomacy")

func _on_propaganda_button_pressed():
	_allocate_point("propaganda")

func _on_authority_button_pressed():
	_allocate_point("authority")

func _on_start_button_pressed():
	if points == 0:
		GlobalData.player_traits = traits.duplicate()
		GameStateManager.transition_to(GameStateManager.State.GAME)
	else:
		%ErrorLabel.text = "Allocate all points before starting!"
		%ErrorAnimation.play("error_flash")

func _on_reset_button_pressed():
	traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
	points = 10
	_update_ui()
	_play_sound("res://sounds/reset.wav")

func _shake_buttons():
	var tween = create_tween()
	for btn in attributes.values():
		tween.parallel().tween_property(btn, "position:x", btn.position.x + 5, 0.1)
		tween.parallel().tween_property(btn, "position:x", btn.position.x - 5, 0.1)
		tween.parallel().tween_property(btn, "position:x", btn.position.x, 0.1)

func _play_sound(path):
	var sound = AudioStreamPlayer.new()
	sound.stream = load(path)
	add_child(sound)
	sound.play()
	await sound.finished
	sound.queue_free()
