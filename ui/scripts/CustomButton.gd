extends Button

# Exportirana varijabla za efekte
export var effects: Dictionary = {}

# Optional: Add a function to handle button presses
func _pressed():
	if effects.has("on_press"):
		# Call the effect defined in the "on_press" key
		var effect = effects["on_press"]
		if callable(effect):
			effect.call_func()
