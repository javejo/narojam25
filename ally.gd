extends CharacterBody2D
class_name Ally
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var attack_timer: Timer = $AttackTimer
@onready var marker_2d: Marker2D = $Marker2D
@onready var lifespan: Timer = $Lifespan
var enemy_type: String

@export var stats: EnemyStats
var player = null
var speed = 100
const BONE = preload("uid://dqncm2sqkp85b")

func _ready():
	lifespan.wait_time = Globals.ally_lifespan
	#$Sprite2D.texture = stats.sprite
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("walking")
	
	
func _physics_process(delta):
	if player:

		marker_2d.look_at(get_global_mouse_position())
		speed = player.speed
		var direction = (player.global_position - global_position).normalized()
		var distance = global_position.distance_to(player.global_position)
		velocity = direction * speed

		if distance < 100:
			velocity = Vector2.ZERO
		
		move_and_slide()

		

# Los huesos dan vueltas por algun motivo
func _on_attack_timer_timeout() -> void:
	var bone_instance = BONE.instantiate()
	get_tree().root.add_child(bone_instance)
	#bone_instance.transform = marker_2d.position
	#bone_instance.scale = Globals.bone_scale
	#bone_instance.position = position


func _on_lifespan_timeout() -> void:
	queue_free()


func _on_fading_timeout() -> void:
	animation_player_2.play("fading")
