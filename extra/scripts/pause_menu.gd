extends CanvasLayer

var game_paused: bool = false
@onready var options_menu: CenterContainer = $CenterContainer/VBoxContainer/VBoxContainer/OptionsMenu
@onready var options_button: Button = $CenterContainer/VBoxContainer/VBoxContainer/PauseOptions
@onready var exit_button: Button = $CenterContainer/VBoxContainer/VBoxContainer/PauseExit
@onready var resume_button: Button = $CenterContainer/VBoxContainer/VBoxContainer/Resume

var bus_index: int

func _ready() -> void:
	visible = false
	bus_index = AudioServer.get_bus_index("BGM")

func pause():
	#get_tree().paused = true
	#$"../../BGM".set_stream_paused(true)
	Engine.time_scale = 0
	AudioServer.set_bus_effect_enabled(bus_index,0,true)
	game_paused = true
	visible = true
	
func resume():
	#get_tree().paused = false
	#$"../../BGM".set_stream_paused(false)
	Engine.time_scale = 1
	AudioServer.set_bus_effect_enabled(bus_index,0,false)
	game_paused = false
	visible = false
	
func pause_menu():
	if Input.is_action_just_pressed("escape") and !game_paused:
		pause()
	elif Input.is_action_just_pressed("escape") and game_paused:
		resume()


# Main menu
func _on_resume_pressed() -> void:
	resume()
	
func _on_pause_options_pressed() -> void:
	options_menu.visible = true
	options_button.visible = false
	exit_button.visible = false
	resume_button.visible = false

func _on_pause_exit_pressed() -> void:
	resume()
	SceneTransition.change_scene("res://extra/scenes/main_menu.tscn", "scroll")

# Options menu
func _on_back_pressed() -> void:
	options_menu.visible = false
	options_button.visible = true
	exit_button.visible = true
	resume_button.visible = true

func _process(delta: float) -> void:
	pause_menu()
