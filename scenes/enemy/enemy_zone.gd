extends Area2D
class_name EnemyZone

@export var enemy_scene: PackedScene
@export var spawn_rate: float = 3.0
@export var max_enemies: int = 5

@onready var collider: CollisionShape2D = $CollisionShape2D

var current_enemies: int = 0

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)

func spawn_enemy() -> void:
	if current_enemies >= max_enemies: return
	var spawn_position: Vector2 = get_random_position()
	var new_enemy: Enemy = enemy_scene.instantiate()
	new_enemy.global_position = spawn_position
	new_enemy.enemy_zone = self
	new_enemy.on_enemy_die.connect(_on_enemy_die)
	get_tree().root.add_child(new_enemy)
	current_enemies += 1

func _on_enemy_die() -> void:
	current_enemies -= 1
	print("X_X")

func get_random_position() -> Vector2:
	var shape = collider.shape as RectangleShape2D
	var half_size = shape.size / 2
	var random_position: = Vector2(
		randf_range(-half_size.x, half_size.x),
		randf_range(-half_size.y, half_size.y),
	)
	return collider.global_position + random_position

func _on_timeout() -> void:
	spawn_enemy()
