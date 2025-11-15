extends Sprite2D

@onready var revive_zone: Area2D = $ReviveZone
@onready var collision: CollisionShape2D = $ReviveZone/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(Globals.revive_area_scale, Globals.revive_area_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
