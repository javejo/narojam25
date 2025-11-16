extends CharacterBody2D

@export var speed = 400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var direction = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("spin")
	scale = Globals.bone_scale * scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * delta * speed
	#velocity = direction * speed


func _on_bone_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
