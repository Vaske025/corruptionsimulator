# systems/country_simulation.gd
extends Node

var stats = {
	"economy": 50,
	"corruption": 30,
	"public_support": 70
}

func _process(delta):
	stats.corruption += delta * 0.1
	stats.public_support -= stats.corruption * delta * 0.05
