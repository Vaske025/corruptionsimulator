# ui/scripts/country_simulation.gd
class_name CountrySimulation
extends Node

var stats: Dictionary = {
	"economy": 50,
	"corruption": 30,
	"public_support": 70,
	"unemployment": 15,
	"education": 45,
	"healthcare": 60,
	"morality": 50,    # Added morality
	"authority": 50,   # Added authority
	"diplomacy": 50,   # Added diplomacy
	"propaganda": 50,  # Added propaganda
	"security": 50     # Added security
}

var policies: Dictionary = {
	"tax_rate": 20,
	"police_funding": 50,
	"social_programs": 30
}

# New feature: International Relations (0–100 scale)
var foreign_relations: int = 50

# If you want the simulation to update continuously (for testing purposes or if desired),
# uncomment the _process callback below.
func _process(delta: float) -> void:
	# This calls update_turn every frame.
	# (If you prefer turn-based updates only, remove or disable this method and
	#  make sure to call update_turn() manually when a turn ends.)
	update_turn(delta)

# Call this function to update the simulation (e.g., at the end of a turn)
func update_turn(delta: float = 1.0) -> void:
	# Economy simulation: update based on tax rate.
	stats.economy += (100 - policies.tax_rate) * 0.01 * delta
	stats.economy = clamp(stats.economy, 0, 100)

	# Corruption simulation: slower corruption increase.
	stats.corruption += (0.05 + policies.police_funding * 0.0005) * delta
	stats.corruption = clamp(stats.corruption, 0, 100)

	# Public support simulation: based on healthcare, education, corruption, and tax rate.
	stats.public_support = clamp(stats.public_support + (
		(stats.healthcare * 0.1 + stats.education * 0.05) -
		stats.corruption * 0.15 -
		policies.tax_rate * 0.1
	) * delta, 0, 100)

	# Unemployment simulation.
	stats.unemployment += (policies.tax_rate * 0.05 - stats.education * 0.02) * delta
	stats.unemployment = clamp(stats.unemployment, 0, 100)

	# Morality simulation: affected by corruption, propaganda, and diplomacy.
	stats.morality += (-stats.corruption * 0.05 + stats.propaganda * 0.02 + stats.diplomacy * 0.03) * delta
	stats.morality = clamp(stats.morality, 0, 100)

	# International relations simulation: influenced by diplomacy and corruption.
	foreign_relations += (stats.diplomacy * 0.05 - stats.corruption * 0.03) * delta
	foreign_relations = clamp(foreign_relations, 0, 100)

	# Trigger a random corruption event if corruption is very high.
	if stats.corruption > 70 and randi() % 10 < 3:
		EventBusManager.emit_protest_spawned({
			"type": "corruption_event",
			"message": "A corruption scandal is brewing!"
		})
