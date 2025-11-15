extends Node

const CADAVER = preload("uid://bbpnohwlm26rf")
const ENEMY = preload("uid://bnuouygf0am1w")

@export var enemies: Array[EnemyStats] = [
	preload("uid://bqt2roop3itjx"),
	preload("uid://duxpb3dbll4ff"),
	preload("uid://btbfadutuekuh")	
	
]
@onready var player_level: ProgressBar = %XPBar
@onready var player: CharacterBody2D = %Player

signal enemy_died

func _ready() -> void:
	pass
	#enemy_died.connect(_on_enemy_died)
	#player_level.value = player.xp / player.xp_requirement

func _on_enemy_died():
	print("Enemy died")
	enemy_died.emit()

func _on_timer_timeout() -> void:
	spawn_enemy(enemies.pick_random())

func spawn_enemy(stats: EnemyStats):
	var spawned_enemy: Enemy = ENEMY.instantiate()
	spawned_enemy.stats = stats
	spawned_enemy.enemy_died.connect(_on_enemy_died)
	add_child(spawned_enemy)
	spawned_enemy.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
