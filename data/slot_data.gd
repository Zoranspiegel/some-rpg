extends Resource
class_name SlotData

@export var item: ItemInventoryData
@export var quantity: int = 1

func _init(_item: ItemInventoryData, _quantity: int) -> void:
	item = _item
	quantity = _quantity
