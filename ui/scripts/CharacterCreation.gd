# ui/scripts/CharacterCreation.gd
extends Control

var traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
var points: int = 10

func _ready():
	_update_labels()

func _update_labels():
	%DiplomacyLabel.text = "Diplomacy: %d" % traits.diplomacy
	%PropagandaLabel.text = "Propaganda: %d" % traits.propaganda
	%AuthorityLabel.text = "Authority: %d" % traits.authority
	%PointsLabel.text = "Points Remaining: %d" % points

func _on_diplomacy_button_pressed():
	if points > 0:
		traits.diplomacy += 1
		points -= 1
		_update_labels()

func _on_propaganda_button_pressed():
	if points > 0:
		traits.propaganda += 1
		points -= 1
		_update_labels()

func _on_authority_button_pressed():
	if points > 0:
		traits.authority += 1
		points -= 1
		_update_labels()

func _on_start_button_pressed():
	Global.player_traits = traits
	GameState.transition_to(GameState.State.GAME)
