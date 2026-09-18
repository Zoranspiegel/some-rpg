extends Area2D
class_name Enemy

signal on_enemy_die

@export var max_health: float = 10.0
@export var damage: float = 2.0
@export var exp_amount: float = 20.0

@onready var selector: Sprite2D = $Selector
@onready var health_component: HealthComponent = $HealthComponent

var enemy_zone: EnemyZone

func _ready() -> void:
	health_component.setup(max_health)

func select_enemy() -> void:
	selector.show()

func deselect_enemy() -> void:
	selector.hide()
