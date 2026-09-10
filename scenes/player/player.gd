extends CharacterBody2D
class_name Player

@export_group("Stats")
@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 60.0
@export var damge: float = 5.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 0.0

@onready var anim_sprite: AnimatedSprite2D = $AnimSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var fsm: FSM = $FSM

var current_mana: float
var last_direction: String = "down"

func _process(delta: float) -> void:
	if fsm.curr_state:
		fsm.curr_state.process_state(delta)

func is_moving() -> bool:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	return direction.length() > 0

func update_direction(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return
	
	if abs(input_vector.x) > abs(input_vector.y):
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"

func play_direction_anim(anim_name: String) -> void:
	anim_sprite.play("%s_%s" % [anim_name, last_direction])

func setup() -> void:
	reset_health()
	reset_mana()

func reset_health() -> void:
	health_component.setup(max_health)
	EventBus.on_player_health_updated.emit(max_health, max_health)

func reset_mana() -> void:
	current_mana = max_mana
	EventBus.on_player_mana_updated.emit(max_mana, max_mana)

func use_mana(value: float) -> void:
	current_mana -= value
	current_mana = max(current_mana, 0)
	EventBus.on_player_mana_updated.emit(current_mana, max_mana)
