# systems/country_simulation.gd
class_name CountrySimulation
extends Node

var stats = {
	"economy": 50,
	"corruption": 30,
	"public_support": 70,
	"unemployment": 15,
	"education": 45,
	"healthcare": 60,
	"morality": 50,  # Added morality
	"authority": 50,  # Added authority
	"diplomacy": 50,  # Added diplomacy
	"propaganda": 50,  # Added propaganda
	"security": 50  # Added security
}

var policies = {
	"tax_rate": 20,
	"police_funding": 50,
	"social_programs": 30
}

func _process(delta):
	# Economy simulation
	stats.economy += (100 - policies.tax_rate) * delta * 0.01  # Slower economy growth
	stats.economy = clamp(stats.economy, 0, 100)

	# Corruption simulation
	stats.corruption += delta * (0.05 + policies.police_funding * 0.0005)  # Slower corruption increase
	stats.corruption = clamp(stats.corruption, 0, 100)

	# Public support simulation
	stats.public_support = clamp(stats.public_support + (
		(stats.healthcare * 0.1 + stats.education * 0.05) - 
		stats.corruption * 0.15 - 
		policies.tax_rate * 0.1
	) * delta, 0, 100)

	# Unemployment simulation
	stats.unemployment += (policies.tax_rate * 0.05 - stats.education * 0.02) * delta
	stats.unemployment = clamp(stats.unemployment, 0, 100)

	# Morality simulation
	stats.morality += (-stats.corruption * 0.05 + stats.propaganda * 0.02 + stats.diplomacy * 0.03) * delta
	stats.morality = clamp(stats.morality, 0, 100)

	# Authority simulation
	stats.authority += (stats.security * 0.03 - stats.public_support * 0.01) * delta
	stats.authority = clamp(stats.authority, 0, 100)

	# Diplomacy simulation
	stats.diplomacy -= (stats.corruption * 0.02 + stats.unemployment * 0.01) * delta
	stats.diplomacy = clamp(stats.diplomacy, 0, 100)

	# Propaganda simulation
	stats.propaganda += (stats.social_programs * 0.01 - stats.corruption * 0.01) * delta
	stats.propaganda = clamp(stats.propaganda, 0, 100)

	# Security simulation
	stats.security += (policies.police_funding * 0.01 - stats.corruption * 0.01) * delta
	stats.security = clamp(stats.security, 0, 100)

	# Debugging output
	print("Stats updated:")
	print("Economy:", stats.economy)
	print("Corruption:", stats.corruption)
	print("Public Support:", stats.public_support)
	print("Unemployment:", stats.unemployment)
	print("Education:", stats.education)
	print("Healthcare:", stats.healthcare)
	print("Morality:", stats.morality)
	print("Authority:", stats.authority)
	print("Diplomacy:", stats.diplomacy)
	print("Propaganda:", stats.propaganda)
	print("Security:", stats.security)
