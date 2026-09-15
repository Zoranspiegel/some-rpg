extends Node

signal on_inventory_changed
signal on_equipment_changed

const INVENTORY_SIZE: int = 30

var inventory: Array[SlotData]

func _ready() -> void:
	inventory.clear()
	inventory.resize(INVENTORY_SIZE)

func get_empty_slot_indexes() -> Array[int]:
	var empty: Array[int] = []
	for i in inventory.size():
		if inventory[i] == null:
			empty.append(i)
	
	return empty

func find_item_indexes(item: ItemInventoryData, with_space: bool = false) -> Array[int]:
	var found: Array[int] = []
	for i in inventory.size():
		var slot = inventory[i]
		if slot and slot.item == item:
			if with_space:
				if slot.quantity < item.max_stack:
					found.append(i)
			else:
				found.append(i)
	
	return found

func add_item(item: ItemInventoryData, amount: int = 1) -> void:
	if not item:
		return
	
	var remaining = amount
	# 1. Stack onto existing stacks that have available space
	if item.max_stack > 1:
		for i in find_item_indexes(item, true):
			if remaining <= 0:
				break
				
			var slot = inventory[i]
			var space = item.max_stack - slot.quantity
			var to_give = min(space, remaining)
				
			slot.quantity += to_give
			remaining -= to_give
	
		# 2. Use empty slots for the remaining items
	if remaining > 0:
		for i in get_empty_slot_indexes():
			if remaining <= 0:
				break
			
			var space = item.max_stack
			var to_give = min(space, remaining)
			
			inventory[i] = SlotData.new(item, to_give)
			remaining -= to_give

	var added = amount - remaining
	if added > 0:
		on_inventory_changed.emit()

func get_slot(index: int) -> SlotData:
	if index >= 0 and index < inventory.size():
		return inventory[index]
	return null
