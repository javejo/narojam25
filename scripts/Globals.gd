extends Node

var bone_damage: float = 2
var ability_cooldown: float = 5
var ally_lifespan: float = 10
var revive_area_scale: float = 2
var enemy_life_scale: float = 1
var bone_scale: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	bone_damage = 2
	ability_cooldown = 5
	ally_lifespan = 10
	revive_area_scale = 2
	enemy_life_scale = 1
	bone_scale = 1
