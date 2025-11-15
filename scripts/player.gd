extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@onready var revive_area: Sprite2D = $ReviveArea
const REVIVE_AREA = preload("uid://b7dg1bewj5um2")
@onready var player_hand: Sprite2D = $PlayerHand
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_manager: Node = $"../EnemyManager"
@onready var ability_timer: Timer = $AbilityTimer
@onready var revive_progress: TextureProgressBar = %ReviveProgress


var xp: float = 0
var level: int = 1
var xp_requirement: float = 20
var ability_ready: bool = true

#signal revive

func _ready() -> void:
	animation_player.play("hand_move")
	ability_timer.wait_time = Globals.ability_cooldown

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

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
