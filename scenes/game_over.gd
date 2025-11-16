extends CanvasLayer

const MAIN_SCENCE = preload("res://scenes/main.tscn")


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	queue_free()
	Engine.time_scale = 1
