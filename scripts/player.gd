extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@onready var revive_area: Sprite2D = $ReviveArea
const REVIVE_AREA = preload("uid://b7dg1bewj5um2")
@onready var player_hand: Sprite2D = $PlayerHand
@onready var player_body: Sprite2D = $PlayerBody
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_manager: Node = $"../EnemyManager"
@onready var ability_timer: Timer = $AbilityTimer
@onready var revive_progress: TextureProgressBar = %ReviveProgress
@onready var health_bar: TextureProgressBar = $HealthBar


var xp: float = 0
var level: int = 1
var xp_requirement: float = 10
var ability_ready: bool = true
var immunity_time: float = 0.5

var health = 100

signal health_changed
signal player_died

func _ready() -> void:
	animation_player.play("hand_move")
	ability_timer.wait_time = Globals.ability_cooldown
	health_bar.value = health

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

	if direction.x < 0:
		player_body.flip_h = true
		player_hand.flip_h = true
	else:
		player_body.flip_h = false
		player_hand.flip_h = false
		

	move_and_slide()
	
	if !ability_ready:
		revive_progress.value = (100 * (ability_timer.wait_time - ability_timer.time_left)) / ability_timer.wait_time
	
	
	if Input.is_action_just_pressed("revive") and ability_ready:
		var rev_area_instance = REVIVE_AREA.instantiate()
		add_child(rev_area_instance)
		rev_area_instance.show()
		
		#await get_tree().create_timer(1.0).timeout
		#rev_area_instance.queue_free()

		
	if Input.is_action_just_released("revive") and ability_ready:
		ability_timer.start()
		ability_ready = false
		if has_node("ReviveArea"):
			get_node("ReviveArea").queue_free()	


func _on_ability_timer_timeout() -> void:
	ability_ready = true


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		health -= 1
		health_changed.emit()
		
	if area.is_in_group("Boss"):
		health -= 5
		health_changed.emit()
	
	player_body.material.set("shader_parameter/flash_amount", 1)
	player_hand.material.set("shader_parameter/flash_amount", 1)
	$Hitbox.set_deferred("disabled", true)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(immunity_time).timeout
	player_body.material.set("shader_parameter/flash_amount", 0)
	player_hand.material.set("shader_parameter/flash_amount", 0)
	$Hitbox.set_deferred("disabled", false)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)
	






		
func _on_health_changed() -> void:
	health_bar.value = health
	if health <= 0:
		player_died.emit()
		queue_free()


func _on_button_pressed() -> void:
	enemy_manager.spawn_boss()
