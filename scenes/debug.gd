extends Node

const CADAVER = preload("uid://bbpnohwlm26rf")


func _on_button_pressed() -> void:
	var cadaver_instance = CADAVER.instantiate()
	get_tree().root.add_child(cadaver_instance)
	cadaver_instance.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
