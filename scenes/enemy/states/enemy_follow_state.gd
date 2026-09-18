extends EnemyState
class_name EnemyFollowState

@export var follow_speed: float = 50.0
@export var stop_distance: float = 15.0

func enter_state() -> void:
	print("ENEMY_FOLLOW_SATATE:ENTER")

func process_state(delta: float) -> void:
	if not enemy or not Refs.player: return
	
	var direction = enemy.global_position.direction_to(Refs.player.global_position)
	var distance_to_player = enemy.global_position.distance_to(Refs.player.global_position)
	if distance_to_player > stop_distance:
		enemy.update_anim_sprite(direction)
		enemy.global_position += direction * follow_speed * delta
