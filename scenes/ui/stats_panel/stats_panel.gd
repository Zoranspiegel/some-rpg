extends PanelContainer
class_name StatsPanel

@onready var damage_label: Label = %DamageLabel
@onready var hp_label: Label = %HPLabel
@onready var vel_label: Label = %VelLabel
@onready var mana_label: Label = %ManaLabel
@onready var crit_label: Label = %CritLabel
@onready var crit_dmg_label: Label = %CritDMGLabel

@onready var current_level_label: Label = %CurrentLevelLabel
@onready var current_points_label: Label = %CurrentPointsLabel

@onready var str_points_label: Label = %STRPointsLabel
@onready var dex_points_label: Label = %DEXPointsLabel
@onready var int_points_label: Label = %INTPointsLabel


func _on_str_button_pressed() -> void:
	pass # Replace with function body.


func _on_dex_button_pressed() -> void:
	pass # Replace with function body.


func _on_int_button_pressed() -> void:
	pass # Replace with function body.
