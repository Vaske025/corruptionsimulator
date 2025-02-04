extends Button
class_name CustomButton

@export var effects: Dictionary = {}

func _pressed():
	if effects.has("on_press"):
		# Call the effect defined in the "on_press" key
		var effect = effects["on_press"]
		if effect is Callable:
			effect.call()
