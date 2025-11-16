extends CanvasLayer

const MAIN_SCENCE = preload("res://scenes/main.tscn")
@onready var label: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel


func _on_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "fade")
	queue_free()
	Engine.time_scale = 1
	Globals.start_game()
