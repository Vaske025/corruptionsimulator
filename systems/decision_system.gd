# systems/decision_system.gd
class_name DecisionSystem
extends Node

var available_decisions = [
	{
		"id": "raise_taxes",
		"title": "Raise Taxes",
		"effects": {"economy": +10, "public_support": -15},
		"cost": 0
	},
	{
		"id": "anti_corruption_campaign",
		"title": "Launch Anti-Corruption Campaign",
		"effects": {"corruption": -20, "economy": -5},
		"cost": 1000
	}
]

func make_decision(decision_id: String):
	var decision = null
	for d in available_decisions:
		if d["id"] == decision_id:
			decision = d
			break
	
	if decision:
		apply_effects(decision["effects"])
		GlobalGameData.game_history.append(decision)
	else:
		push_error("Decision not found: " + decision_id)
func apply_effects(effects: Dictionary):
	for stat in effects:
		if stat in Global.country_stats:
			Global.country_stats[stat] += effects[stat]
