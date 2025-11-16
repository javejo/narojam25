extends CanvasLayer

const MAIN_SCENCE = preload("res://scenes/main.tscn")


func _on_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "fade")
	queue_free()
	Engine.time_scale = 1
