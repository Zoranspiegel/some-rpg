extends EnemyState
class_name EnemyWanderState

@export var min_move_speed: float = 20.0
@export var max_move_speed: float = 20.0
@export var arrival_distance: float = 0.5

var target_pos: Vector2

func enter_state() -> void:
	print("ENEMY_WANDER_SATATE:ENTER")
	pick_new_target()

func process_state(delta: float) -> void:
	if not enemy: return
	
	#Move to target
	var direction: Vector2 = enemy.global_position.direction_to(target_pos)
	var speed: float = randf_range(min_move_speed, max_move_speed)
	enemy.global_position += direction * speed * delta
	
	# Update animation
	enemy.update_anim_sprite(direction)
	
	# Check arrive at destination
	if enemy.global_position.distance_to(target_pos) < arrival_distance:
		pick_new_target()


func pick_new_target() -> void:
	if enemy and enemy.enemy_zone:
		target_pos = enemy.enemy_zone.get_random_position()
