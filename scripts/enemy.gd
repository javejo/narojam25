extends CharacterBody2D
class_name Enemy

@export var stats: EnemyStats
var player = null
var health = null
var speed = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const CADAVER = preload("uid://bbpnohwlm26rf")
const PARTICLES = preload("uid://dhlgpgokl7fow")

@onready var damage: Label = $Damage

signal enemy_died

func _ready():
	$Sprite2D.texture = stats.sprite
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("moving")
	health = stats.health
	#speed = stats.speed
	
func _physics_process(delta):
	if player:
		position = position.move_toward(player.global_position, delta * speed)
		#look_at(player.position)
		move_and_slide()

		
		move_and_slide()
	
	# Si la distancia es inferior a X poner que velocidad = 0


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		hit()
		#die()
		#queue_free()

func hit():
	health -= int(floor(Globals.bone_damage))
	#damage.show()
	animation_player.play("hit")
	damage.text = str(int(Globals.bone_damage))
	
	if health <= 0:
		die()

func die():
	var cadaver_instance = CADAVER.instantiate()
	get_tree().root.add_child(cadaver_instance)
	cadaver_instance.enemy_type = stats.enemy_type
	cadaver_instance.global_position = global_position
	enemy_died.emit()
	queue_free()
	var particles = PARTICLES.instantiate()
	get_tree().root.add_child(particles)
	particles.global_position = global_position
	particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	particles.queue_free()
