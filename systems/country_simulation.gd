class_name CountrySimulation
extends Node

var stats = {
	"economy": 50,
	"corruption": 30,
	"public_support": 70,
	"unemployment": 15,
	"education": 45,
	"healthcare": 60
}

var policies = {
	"tax_rate": 20,
	"police_funding": 50,
	"social_programs": 30
}

func _process(delta):
	stats.economy += (100 - policies.tax_rate) * delta * 0.05
	stats.corruption += delta * (0.1 + policies.police_funding * 0.001)
	stats.public_support = clamp(stats.public_support + (
		(stats.healthcare * 0.2 + stats.education * 0.1) - 
		stats.corruption * 0.3 - 
		policies.tax_rate * 0.2
	) * delta, 0, 100)
	
	stats.unemployment += (policies.tax_rate * 0.1 - stats.education * 0.05) * delta
