extends Node

@export var main_menu: String

func _ready() -> void:
	$Node/AnimationPlayer.play("music_fadein")

func _on_button_pressed() -> void:
	print("going back")
	#SceneTransition.change_scene(MAIN_MENU, "scroll")
	SceneTransition.change_scene(main_menu, "fade")
	$Node/AnimationPlayer.play("music_fadeout")
