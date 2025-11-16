extends Node

const CADAVER = preload("uid://bbpnohwlm26rf")
const ENEMY = preload("uid://bnuouygf0am1w")
const ENEMY_BOSS = preload("uid://bbgdbh873f1c2")

@export var enemies: Array[EnemyStats] = [
	preload("uid://bqt2roop3itjx"),
	preload("uid://duxpb3dbll4ff"),
	preload("uid://btbfadutuekuh")	
	
]
@onready var player_level: ProgressBar = %XPBar
@onready var player: CharacterBody2D = %Player

var max_enemies: int = 50
var enemy_number: int = 0

var enemy_life_scale: float = 1.0

signal enemy_died

func _ready() -> void:
	pass
	#enemy_died.connect(_on_enemy_died)
	#player_level.value = player.xp / player.xp_requirement

func _on_enemy_died():
	print("Enemy died")
	enemy_died.emit()
	enemy_number -= 1

func _on_timer_timeout() -> void:
	if enemy_number < 50:
		var spawn_number = randi_range(1, 5)
		for i in spawn_number:
			spawn_enemy(enemies.pick_random())

func spawn_enemy(stats: EnemyStats):
	var spawned_enemy: Enemy = ENEMY.instantiate()
	spawned_enemy.stats = stats
	#spawned_enemy.health = enemy_life_scale * spawned_enemy.health
	spawned_enemy.enemy_died.connect(_on_enemy_died)
	add_child(spawned_enemy)
	spawned_enemy.global_position = Vector2(randi_range(-1000,1000), randi_range(-1000,1000))
	enemy_number += 1


func _on_difficulty_increased() -> void:
	$Timer.wait_time = 0.95 * $Timer.wait_time
	Globals.enemy_life_scale += 0.2

func spawn_boss():
	var boss_instance = ENEMY_BOSS.instantiate()
	boss_instance.position = Vector2(player.global_position.x + randi_range(-100, 100),
	player.global_position.y + randi_range(-100, 100))
	add_child(boss_instance)
	
	var enemy_instance = ENEMY.instantiate()
	add_child(enemy_instance)
	enemy_instance.boss = boss_instance
	enemy_instance.player = null
	


func _on_boss_timer_timeout() -> void:
	spawn_boss()
