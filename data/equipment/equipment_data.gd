extends ItemInventoryData
class_name EquipmentData

enum EquipmentType {
	HELMET,
	CHEST,
	WEAPON,
	LEGS,
	RING
}

@export var equipment_type: EquipmentType
@export var bonus_damage: float = 0.0
@export var bonus_defense: float = 0.0

func _init() -> void:
	type = Type.EQUIPMENT
	max_stack = 1

func get_equip_key() -> String:
	match equipment_type:
		EquipmentType.HELMET: return "helmet"
		EquipmentType.CHEST: return "chest"
		EquipmentType.LEGS: return "legs"
		EquipmentType.WEAPON: return "weapon"
		EquipmentType.RING: return "ring"
	return ""
