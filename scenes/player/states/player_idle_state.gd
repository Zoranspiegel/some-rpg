extends PlayerState
class_name PlayerIdleState

func enter_state() -> void:
	player.play_direction_anim("idle")

func _input(_event: InputEvent) -> void:
	if player.is_moving():
		fsm.transition_to("Walk")
