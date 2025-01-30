extends Control

var traits = {"diplomacy": 0, "propaganda": 0, "authority": 0}
var points = 10

func _update_labels():
	$VBoxContainer/Diplomacy/Label.text = "Diplomacy: %d" % traits.diplomacy
	$VBoxContainer/Propaganda/Label.text = "Propaganda: %d" % traits.propaganda
	$VBoxContainer/Authority/Label.text = "Authority: %d" % traits.authority
	$VBoxContainer/PointsLabel.text = "Points: %d" % points

func _on_DiplomacyButton_pressed():
	if points > 0:
		traits.diplomacy += 1
		points -= 1
		_update_labels()

# Уради исто за остала дугмад

func _on_StartButton_pressed():
	Global.player_traits = traits  # Global скрипта је потребна!
	get_tree().change_scene_to_file("res://World.tscn")
