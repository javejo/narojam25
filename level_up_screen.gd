extends CanvasLayer

@export var ability_pool: Array[PackedScene]
@onready var container: HBoxContainer = $CenterContainer/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_abilities()
	pause() # Replace with function body.

func pick_abilities():
	ability_pool.shuffle()
	var abilities = ability_pool
	for i in 3:
		var ability = ability_pool.pop_front().instantiate()
		ability.ability_selected.connect(_on_ability_selected)
		container.add_child(ability)
	
func _on_ability_selected():
	resume()		

func pause():
	Engine.time_scale = 0
	
func resume():
	Engine.time_scale = 1
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		resume()
		queue_free()


func _on_less_cooldown_pressed() -> void:
	Globals.ability_cooldown = Globals.ability_cooldown * 0.8
	resume()
	queue_free()
