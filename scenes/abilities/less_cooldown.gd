extends Button

signal ability_selected

func _on_pressed() -> void:
	Globals.ability_cooldown = Globals.ability_cooldown / 2 # Replace with function body.
	ability_selected.emit()
