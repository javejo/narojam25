extends CharacterBody2D
#class_name Enemy

var player = null
var health = 1000
var speed = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#const CADAVER = preload("uid://bbpnohwlm26rf")
const PARTICLES = preload("uid://dhlgpgokl7fow")
const ENEMY = preload("uid://bnuouygf0am1w")

@export var enemies: Array[EnemyStats] = [
	preload("uid://bqt2roop3itjx"),
	preload("uid://duxpb3dbll4ff"),
	preload("uid://btbfadutuekuh")	
	
]

@onready var damage: Label = $Damage
#@onready var hitbox: CollisionShape2D = $Hurtbox

signal enemy_died

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("moving")
	for i in 10:
		spawn_enemy(enemies.pick_random())

func spawn_enemy(stats: EnemyStats):
	var spawned_enemy: Enemy = ENEMY.instantiate()
	spawned_enemy.boss = $"."
	add_child(spawned_enemy)
	spawned_enemy.position = Vector2(global_position.x + randi_range(1,10), global_position.y + randi_range(1,10))
	
func _physics_process(delta):
	if player:
		position = position.move_toward(player.global_position, delta * speed)
		#look_at(player.position)
		move_and_slide()



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		hit()
	
func hit():
	health -= int(floor(Globals.bone_damage))
	animation_player.play("hit")
	damage.text = str(int(Globals.bone_damage))
	
	if health <= 0:
		die()
		
	

func die():
	enemy_died.emit()
	queue_free()
	var particles = PARTICLES.instantiate()
	get_tree().root.add_child(particles)
	particles.position = global_position
	particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()
