extends Button

signal ability_selected

func _on_pressed() -> void:
	Globals.ally_lifespan += 2
	ability_selected.emit()
