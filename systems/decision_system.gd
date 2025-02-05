# systems/decision_system.gd
class_name DecisionSystem
extends Node

# Dictionary of available decisions.
var decision_dict: Dictionary = {
	"raise_taxes": {
		"title": "Raise Taxes",
		"effects": {"economy": 10, "public_support": -15, "morality": -5},
		"cost": 0
	},
	"anti_corruption_campaign": {
		"title": "Launch Anti-Corruption Campaign",
		"effects": {"corruption": -20, "economy": -5, "morality": 10},
		"cost": 1000
	}
}

func make_decision(decision_id: String) -> void:
	if decision_id in decision_dict:
		var decision: Dictionary = decision_dict[decision_id]
		apply_effects(decision["effects"])
		GlobalData.game_history.append(decision)
	else:
		push_error("Decision not found: " + decision_id)

func apply_effects(effects: Dictionary) -> void:
	var country_stats: Dictionary = GlobalData.simulation.stats
	for stat in effects.keys():
		if stat in country_stats:
			country_stats[stat] += effects[stat]
		elif stat == "morality":
			GlobalData.update_morality(effects[stat])
