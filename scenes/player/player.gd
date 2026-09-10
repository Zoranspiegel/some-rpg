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

var last_direction: String = "down"
