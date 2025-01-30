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
	var decision = available_decisions.find(func(d): return d.id == decision_id)
	apply_effects(decision.effects)
	# Add to decision history
	Global.game_history.append(decision)

func apply_effects(effects: Dictionary):
	for stat in effects:
		if stat in Global.country_stats:
			Global.country_stats[stat] += effects[stat]
