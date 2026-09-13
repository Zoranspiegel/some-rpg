extends CanvasLayer
class_name HUD

@onready var equipment_panel: EquipmentPanel = %EquipmentPanel
@onready var inventory_panel: InventoryPanel = %InventoryPanel
@onready var stats_panel: StatsPanel = %StatsPanel
@onready var skills_panel: SkillsPanel = %SkillsPanel

@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var exp_bar: ProgressBar = $ExpBar

@onready var health_label: Label = %HealthLabel
@onready var mana_label: Label = %ManaLabel

func _ready() -> void:
	EventBus.on_player_health_updated.connect(_on_player_health_updated)
	EventBus.on_player_mana_updated.connect(_on_player_mana_updated)
	EventBus.on_player_new_level.connect(_on_player_new_level)

func _on_equipment_button_pressed() -> void:
	equipment_panel.visible = not equipment_panel.visible


func _on_inventory_button_pressed() -> void:
	inventory_panel.visible = not inventory_panel.visible


func _on_stats_button_pressed() -> void:
	stats_panel.visible = not stats_panel.visible


func _on_skills_button_pressed() -> void:
	skills_panel.visible = not skills_panel.visible

func _on_player_health_updated(current: float, max: float) -> void:
	health_bar.value = current / max
	health_label.text = "%d / %d" % [current, max]
	
func _on_player_mana_updated(current: float, max: float) -> void:
	mana_bar.value = current / max
	mana_label.text = "%d / %d" % [current, max]

func _on_player_new_level(current: float, new_level: float) -> void:
	exp_bar.value = current / new_level
