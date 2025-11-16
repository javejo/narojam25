extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func change_scene(target: String, animation: String) -> void:
	match animation:
		"fade":
			$ColorRect.position = Vector2.ZERO
			$ColorRect.show()
			#$ColorRect.modulate = Color(1,1,1,1)
			$AnimationPlayer.play("fade_in")
			await $AnimationPlayer.animation_finished
			$AnimationPlayer.play("fade_out")
			get_tree().change_scene_to_file(target)
			await $AnimationPlayer.animation_finished
			$ColorRect.hide()
		
		"scroll":
			$ColorRect.show()
			# Apaño, porque parece que al hacer el fade in/out he jodido esto
			$ColorRect.modulate = Color(1,1,1,1)
			$TextureRect.show()
			$AnimationPlayer.play("move_in")
			await $AnimationPlayer.animation_finished
			get_tree().change_scene_to_file(target)
			$AnimationPlayer.play("move_out")
			await $AnimationPlayer.animation_finished
			$ColorRect.hide()
			$TextureRect.hide()
