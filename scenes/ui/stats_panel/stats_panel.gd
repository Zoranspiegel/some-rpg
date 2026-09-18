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


func _ready() -> void:
	EventBus.on_player_created.connect(_on_player_created)


func update_stats() -> void:
	if not is_instance_valid(Refs.player): return	
	damage_label.text = "DMG: %d" % Refs.player.damge
	hp_label.text = "HP: %d" % Refs.player.max_health
	vel_label.text = "VEL: %d" % Refs.player.move_speed
	mana_label.text = "MANA: %d" % Refs.player.max_mana
	crit_label.text = "CRIT: %d" % Refs.player.crit_chance + "%"
	crit_dmg_label.text = "C.DMG: %d" % Refs.player.crit_damage + "%"	
	current_level_label.text = "Level %d" % Refs.player.current_level	
	current_points_label.text = "Skill Points: %d" % Refs.player.current_points	
	str_points_label.text = str(Refs.player.strenght_value)
	dex_points_label.text = str(Refs.player.dexterity_value)
	int_points_label.text = str(Refs.player.intelligence_value)


func _on_str_button_pressed() -> void:
	print("STR_BUTTON_PRESSED")


func _on_dex_button_pressed() -> void:
	print("DEX_BUTTON_PRESSED")


func _on_int_button_pressed() -> void:
	print("INT_BUTTON_PRESSED")


func _on_player_created() -> void:
	update_stats()
