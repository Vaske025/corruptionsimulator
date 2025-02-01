class_name DecisionSystem
extends Node

# Lista dostupnih odluka
var decision_list = [
	{
		"id": "raise_taxes",
		"title": "Raise Taxes",
		"effects": {"economy": +10, "public_support": -15, "morality": -5},
		"cost": 0
	},
	{
		"id": "anti_corruption_campaign",
		"title": "Launch Anti-Corruption Campaign",
		"effects": {"corruption": -20, "economy": -5, "morality": +10},
		"cost": 1000
	}
]

# Funkcija za donošenje odluke
func make_decision(decision_id: String):
	var decision = null
	for d in decision_list:
		if d["id"] == decision_id:
			decision = d
			break
	if decision:
		apply_effects(decision["effects"])
		GlobalData.game_history.append(decision)
	else:
		push_error("Decision not found: " + decision_id)

# Funkcija za primenu efekata odluke
func apply_effects(effects: Dictionary):
	var country_stats = GlobalData.simulation.stats
	for stat in effects:
		if stat in country_stats:
			country_stats[stat] += effects[stat]
		elif stat == "morality":
			GlobalData.update_morality(effects[stat])  # Ažuriraj moralnost
