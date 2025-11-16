extends Node

@export var images: Array[Texture2D]
@export var pause_time: float
@export var MAIN_MENU: String
@onready var background_image: TextureRect = $CenterContainer/TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	for i in images.size():
		background_image.texture = images[i]
		animation_player.play("fade_in")
		await get_tree().create_timer(pause_time).timeout
		animation_player.play("fade_out")
		await animation_player.animation_finished
		if i == images.size() - 1:
			SceneTransition.change_scene(MAIN_MENU, "fade")
