extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@onready var revive_area: Polygon2D = $ReviveArea
const REVIVE_AREA = preload("uid://b7dg1bewj5um2")


signal revive

#func _ready() -> void:

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

	move_and_slide()
	
	if Input.is_action_just_pressed("revive"):
		var rev_area_instance = REVIVE_AREA.instantiate()
		add_child(rev_area_instance)
		rev_area_instance.show()
		#await get_tree().create_timer(1.0).timeout
		#rev_area_instance.queue_free()

		
	if Input.is_action_just_released("revive"):
		if has_node("ReviveArea"):
			get_node("ReviveArea").queue_free()	
