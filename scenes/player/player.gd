extends CharacterBody2D
class_name Player

@export_group("Stats")
@export var max_health: float = 10.0
@export var max_mana: float = 50.0
@export var move_speed: float = 60.0
@export var damge: float = 5.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 0.0

@export_group("Exp")
@export var base_exp: float = 100.0
@export var exp_multiplier: float = 2.0

@onready var anim_sprite: AnimatedSprite2D = $AnimSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var enemy_area: Area2D = %EnemyAttackArea
@onready var weapon: Node2D = $Weapon
@onready var fsm: FSM = $FSM

@onready var attack_positions: Dictionary = {
	"down": %Down,
	"left": %Left,
	"up": %Up,
	"right": %Right
}

var current_exp: float
var next_level_exp: float
var current_level: int = 1
var current_points: int = 0

var current_mana: float

var last_direction: String = "down"

#########DEV
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		use_mana(1.0)
	if event.is_action_pressed("move_down"):
		health_component.take_damage(1.0)
#########DEV

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

func add_exp(value: float) -> void:
	current_exp += value
	while current_exp >= next_level_exp:
		level_up()
	
	EventBus.on_player_new_level.emit(current_exp, next_level_exp)

func level_up() -> void:
	current_exp -= next_level_exp
	current_level += 1
	current_points += 4
	next_level_exp *= exp_multiplier
	EventBus.on_player_stats_updated.emit()

func setup() -> void:
	reset_health()
	reset_mana()
	next_level_exp = base_exp

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

func add_mana(value: float) -> void:
	current_mana += value
	current_mana = min(current_mana, max_mana)
	EventBus.on_player_mana_updated.emit(current_mana, max_mana)

func enable_weapon_collision(value: bool):
	enemy_area.monitoring = value


func _on_health_component_on_health_change(curr_health: float) -> void:
	EventBus.on_player_health_updated.emit(curr_health, max_health)


func _on_health_component_on_dead() -> void:
	queue_free()
