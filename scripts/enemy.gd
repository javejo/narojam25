extends CharacterBody2D
class_name Enemy

@export var stats: EnemyStats
var player = null
var boss = null
var health = null
var speed = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const CADAVER = preload("uid://bbpnohwlm26rf")
const PARTICLES = preload("uid://dhlgpgokl7fow")

@onready var damage: Label = $Damage
@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D

signal enemy_died

func _ready():
	$Sprite2D.texture = stats.sprite
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("moving")
	health = stats.health * Globals.enemy_life_scale
	#speed = stats.speed
	
func _physics_process(delta):
	if player:
		position = position.move_toward(player.global_position, delta * speed)
		#look_at(player.position)
		move_and_slide()
	
	if boss:
		player = null
		position = position.move_toward(boss.global_position, delta * speed)
		move_and_slide()



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		hit()
	
	if area.is_in_group("Enemy"):
		hitbox.disabled = true
		await get_tree().create_timer(1).timeout
		hitbox.disabled = false
		#die()
		#queue_free()

func hit():
	$AudioStreamPlayer.play()
	health -= int(floor(Globals.bone_damage))
	#damage.show()
	animation_player.play("hit")
	damage.text = str(int(Globals.bone_damage))
	
	if health <= 0:
		die()
		
func spawn_cadaver():
	var cadaver_instance = CADAVER.instantiate()
	get_tree().root.add_child(cadaver_instance)
	cadaver_instance.enemy_type = stats.enemy_type
	cadaver_instance.timer.autostart = true
	cadaver_instance.global_position = global_position

	

func die():
	$AudioStreamPlayer.play()
	enemy_died.emit()
	if randi_range(1, 10) > 3:
		spawn_cadaver()
	queue_free()
	var particles = PARTICLES.instantiate()
	get_tree().root.add_child(particles)
	particles.position = global_position
	particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(60).timeout
	queue_free()
