extends CharacterBody2D
#class_name Enemy

var player = null
var health = 1000
var speed = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_animation_player: AnimationPlayer = $Hurtbox/HitAnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
const GAME_OVER = preload("uid://dsr84ps025j56")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

#const CADAVER = preload("uid://bbpnohwlm26rf")
const PARTICLES = preload("uid://dhlgpgokl7fow")
const ENEMY = preload("uid://bnuouygf0am1w")

@onready var damage: Label = $Damage

signal enemy_died

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("moving")

func _physics_process(delta):
	if player:
		position = position.move_toward(player.global_position, delta * speed)
		move_and_slide()

func hit():
	print("OUCH!")
	$AudioStreamPlayer.play()
	health -= int(floor(Globals.bone_damage))
	animation_player.play("hit")
	hit_animation_player.play("hit")
	await get_tree().create_timer(0.5).timeout
	damage.text = str(int(Globals.bone_damage))
	
	if health <= 0:
		die()
		
	

func die():
	var game_over = GAME_OVER.instantiate()
	get_tree().root.add_child(game_over)
	game_over.label.text = "[center][shake rate=20.0 level=5 connected=1]YOU WIN![/shake]"
	enemy_died.emit()
	queue_free()
	var particles = PARTICLES.instantiate()
	get_tree().root.add_child(particles)
	particles.position = global_position
	particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		hit()
