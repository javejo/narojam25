extends Button

signal ability_selected

func _on_pressed() -> void:
	Globals.bone_damage += 1
	ability_selected.emit()
