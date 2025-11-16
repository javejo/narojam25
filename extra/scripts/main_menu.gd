extends Node

@export var MAIN_SCENE: String
@onready var main_menu: CenterContainer = $MainMenu
@onready var options_menu: CenterContainer = $OptionsMenu
@onready var background_music: AudioStreamPlayer = $Audio/SampleMusic

# Main Menu Buttons
func _on_start_game_pressed() -> void:
	SceneTransition.change_scene(MAIN_SCENE, "scroll")
	$Audio/AnimationPlayer.play("audio_fadeout")
	
func _on_options_pressed() -> void:
	main_menu.hide()
	options_menu.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

# Options Menu
func _on_back_pressed() -> void:
	options_menu.hide()
	main_menu.show()

# Ready
#func _ready() -> void:
	#background_music.play()
