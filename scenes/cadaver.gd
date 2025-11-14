extends StaticBody2D

@onready var player = get_tree().get_first_node_in_group("Player")

# Cambiar esto para que sea un aliado y no un enemigo
const ENEMY = preload("uid://bnuouygf0am1w")


func _on_revive_radius_area_exited(area: Area2D) -> void:
	if area.is_in_group("ReviveArea"):
		var enemy_instance = ENEMY.instantiate()
		get_tree().root.add_child(enemy_instance)
		enemy_instance.global_position = global_position
		call_deferred("queue_free")
