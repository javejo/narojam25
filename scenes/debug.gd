extends Node
#
#const CADAVER = preload("uid://bbpnohwlm26rf")
#const ENEMY = preload("uid://bnuouygf0am1w")
#
#@export var enemies: Array[EnemyStats] = [
	#preload("uid://bqt2roop3itjx"),
	#preload("uid://duxpb3dbll4ff"),
	#preload("uid://btbfadutuekuh")	
	#
#]
#
#@onready var player_level: ProgressBar = $CanvasLayer/MarginContainer/PlayerLevel
#@onready var player: CharacterBody2D = $"../Player"
#
#func _ready() -> void:
	#player_level.value = player.xp / player.xp_requirement
#
##func _on_timer_timeout() -> void:
	##var enemy_selected = enemies.pick_random()
	##var enemy_instance = enemy_selected.instantiate()
	##enemy_instance.stats = enemy_selected
	##enemy_selected.position = Vector2(randi_range(1, 10), randi_range(1,10))
##
#
#func _on_button_pressed() -> void:
	#var cadaver_instance = CADAVER.instantiate()
	#get_tree().root.add_child(cadaver_instance)
	#cadaver_instance.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
#
#
#
#
#func _on_timer_timeout() -> void:
	#spawn_enemy(enemies.pick_random())
	###var enemy_instance = ENEMY.instantiate()
	##var enemy_selected = enemies.pick_random()
	##var enemy_instance = enemy_selected.instantiate()
	##get_tree().root.add_child(enemy_instance)
	##enemy_instance.stats = enemy_selected
	###enemy_selected.position = Vector2(randi_range(1, 10), randi_range(1,10))
	##enemy_instance.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
#
#func spawn_enemy(stats: EnemyStats):
	#var spawned_enemy: Enemy = ENEMY.instantiate()
	#spawned_enemy.stats = stats
	#get_tree().root.add_child(spawned_enemy)
	#spawned_enemy.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
