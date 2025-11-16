extends Button

signal ability_selected

func _on_pressed() -> void:
	Globals.bone_scale = 0.1 * Globals.bone_scale
	ability_selected.emit()
