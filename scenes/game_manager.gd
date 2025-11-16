extends Node

@onready var player: CharacterBody2D = %Player
@onready var enemy_manager: Node = %EnemyManager
@onready var xp_bar: ProgressBar = %XPBar
const LEVEL_UP_SCREEN = preload("uid://dsgljdagxyyd3")
const CADAVER = preload("uid://bbpnohwlm26rf")
const GAME_OVER = preload("uid://dsr84ps025j56")

var difficulty = 1
@onready var difficulty_timer: Timer = $DifficultyTimer

signal difficulty_increased

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_manager.enemy_died.connect(_on_enemy_died) # Replace with function body.
	player.player_died.connect(_on_player_died)
	xp_bar.value = player.xp
	spawn_cadavers()
	
func spawn_cadavers():
	for i in 30:
		var cadaver_instance = CADAVER.instantiate()
		add_child(cadaver_instance)
		cadaver_instance.global_position = Vector2(randi_range(-2000, 2000), randi_range(-2000, 2000))


func _on_enemy_died():
	player.xp += 1
	print((100 * player.xp) / player.xp_requirement)
	xp_bar.value = (100 * player.xp) / player.xp_requirement
	if player.xp >= player.xp_requirement:
		level_up()
	
func level_up():
	print("LEVEL UP!")
	player.xp = 0
	player.xp_requirement = floor(player.xp_requirement + (0.2 * player.xp_requirement))
	player.level += 1
	var levelup_scene = LEVEL_UP_SCREEN.instantiate()
	get_tree().root.add_child(levelup_scene)
	


func _on_difficulty_timer_timeout() -> void:
	difficulty += 1
	difficulty_timer.wait_time = 0.9 * difficulty_timer.wait_time
	difficulty_increased.emit()

func _on_player_died():
	Engine.time_scale = 0
	var gameover = GAME_OVER.instantiate()
	get_tree().root.add_child(gameover)
