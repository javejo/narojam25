extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@onready var revive_area: Polygon2D = $ReviveArea
#const REVIVE_AREA = preload("uid://b7dg1bewj5um2")

#func _ready() -> void:

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

	move_and_slide()
	
	if Input.is_action_just_pressed("revive"):
		revive_area.show()
		
	if Input.is_action_just_released("revive"):
		revive_area.hide()
		
