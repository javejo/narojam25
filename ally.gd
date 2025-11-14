extends CharacterBody2D
class_name Ally

@export var stats: EnemyStats
var player = null
var speed = 100

func _ready():
	$Sprite2D.texture = stats.sprite
	#$Damage.text = str(stats.health)
	player = get_tree().get_first_node_in_group("Player")
	#speed = stats.speed
	
func _physics_process(delta):
	if player:
		position = position.move_toward(player.position, delta * speed)
		#look_at(player.position)
		move_and_slide()
	
	# Si la distancia es inferior a X poner que velocidad = 0
