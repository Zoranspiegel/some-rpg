extends Area2D
class_name Enemy

signal on_enemy_die

@export var max_health: float = 10.0
@export var damage: float = 2.0
@export var exp_amount: float = 20.0

@onready var fsm: FSM = $FSM
@onready var selector: Sprite2D = $Selector
@onready var health_component: HealthComponent = $HealthComponent
@onready var anim_sprite: AnimatedSprite2D = $AnimSprite

var enemy_zone: EnemyZone

func _ready() -> void:
	health_component.setup(max_health)

func _process(delta: float) -> void:
	if fsm.curr_state:
		fsm.curr_state.process_state(delta)

func update_anim_sprite(direction: Vector2) -> void:
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim_sprite.play("move_right")
		else:
			anim_sprite.play("move_left")
	else:
		if direction.y > 0:
			anim_sprite.play("move_down")
		else:
			anim_sprite.play("move_up")

func select_enemy() -> void:
	selector.show()

func deselect_enemy() -> void:
	selector.hide()
