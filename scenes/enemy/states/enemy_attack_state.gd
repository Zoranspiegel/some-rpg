extends EnemyState
class_name EnemyAttackState

@export var attack_speed:float = 1.0

var attack_timer: float = 0.0
var damage_dealt: bool = false

func enter_state() -> void:
	print("ENEMY_ATTACK_SATATE:ENTER")
	attack_timer = attack_speed
	damage_dealt = false

func process_state(delta: float) -> void:
	if not enemy or not Refs.player:
		fsm.transition_to("Wander")
		return
	
	attack_timer -= delta
	if attack_timer <= attack_speed / 2.0 and not damage_dealt:
		deal_damage()
		damage_dealt = true
	if attack_timer <= 0:
		fsm.transition_to("Follow")

func deal_damage() -> void:
	var distance_to_player: float = enemy.global_position.distance_to(Refs.player.global_position)
	if distance_to_player <= 25.0:
		var angle_to_player: float = enemy.global_position.angle_to_point(Refs.player.global_position)
		var damage_fx_position: Vector2 = enemy.global_position + Vector2.RIGHT.rotated(angle_to_player) * 4
		Refs.create_damage_fx(damage_fx_position, angle_to_player)
		Refs.player.health_component.take_damage(enemy.damage)
		Refs.create_damage_text(Refs.player.global_position, enemy.damage)
