extends Node

var player: Player

const DAMAGE_TEXT = preload("uid://d1b47nkq7m57a")
const DAMAGE_FX_SCENE = preload("uid://cqxdqij4j6341")
const NEW_LEVEL_FX_SCENE = preload("uid://dass68qq2ddai")

func create_damage_fx(position: Vector2, rotation: float = 0.0) -> void:
	create_fx_at_position(DAMAGE_FX_SCENE, position, rotation)


func create_new_level_fx(position: Vector2, rotation: float = 0.0) -> void:
	create_fx_at_position(NEW_LEVEL_FX_SCENE, position, rotation)


func create_damage_text(position: Vector2, amount: float) -> void:
	var label: Label = DAMAGE_TEXT.instantiate()
	label.text = str(amount)
	label.global_position = position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	get_tree().root.add_child(label)
	
	var tween: Tween = create_tween()
	tween.tween_property(label, "global_position:y", label.global_position.y - 20, 0.7)
	tween.tween_callback(label.queue_free)
	


func create_fx_at_position(scene: PackedScene, position: Vector2, rotation: float) -> void:
	var fx: AnimatedSprite2D = scene.instantiate()
	fx.global_position = position
	fx.rotation = rotation
	print(rotation)
	get_tree().root.add_child(fx)
	fx.animation_finished.connect(func(): fx.queue_free())
