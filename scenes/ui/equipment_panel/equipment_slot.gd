extends Button
class_name EquipmentSlot

@export var equipment_type: EquipmentData.EquipmentType
@onready var equipment_icon: TextureRect = $Icon

var equipped_item: EquipmentData

func _ready() -> void:
	clear_data()

func load_data(data: EquipmentData) -> void:
	equipped_item = data
	if data:
		equipment_icon.texture = data.icon
		equipment_icon.show()
	else:
		clear_data()

func clear_data() -> void:
	equipped_item = null
	equipment_icon.hide()
