extends Button

signal ability_selected

func _on_pressed() -> void:
	Globals.revive_area_scale = (Globals.revive_area_scale * 0.5) + Globals.revive_area_scale
	ability_selected.emit()
