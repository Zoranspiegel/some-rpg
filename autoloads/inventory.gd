extends Node

signal on_inventory_changed
signal on_equipment_changed

const INVENTORY_SIZE: int = 30

var inventory: Array[SlotData]

func _ready() -> void:
	inventory.clear()
	inventory.resize(INVENTORY_SIZE)

#region Find
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

func get_slot(index: int) -> SlotData:
	if index >= 0 and index < inventory.size():
		return inventory[index]
	return null

func get_slot_item(index: int) -> ItemInventoryData:
	var slot = get_slot(index)
	if slot:
		return slot.item
	return null
#endregion

#region Add / Remove
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
#endregion

#region Move Slots
func swap_slots(from_index: int, to_index: int) -> void:
	if from_index < 0 or from_index >= inventory.size():
		return
	if to_index < 0 or to_index >= inventory.size():
		return
	
	var temp: SlotData = inventory[from_index]
	inventory[from_index] = inventory[to_index]
	inventory[to_index] = temp
	on_inventory_changed.emit()

func merge_slots(from_index: int, to_index: int) -> void:
	var from_slot: SlotData = get_slot(from_index)
	var to_slot: SlotData = get_slot(to_index)
	
	if not from_slot or not to_slot:
		return
	if from_slot.item != to_slot.item:
		return
	
	var item: ItemInventoryData = from_slot.item
	if item.max_stack <= 1:
		return
	
	var space = item.max_stack - to_slot.quantity
	var to_move = min(space, from_slot.quantity)
	to_slot.quantity += to_move
	from_slot.quantity -= to_move
	
	if from_slot.quantity <= 0:
		inventory[from_index] = null
	elif space <= 0:
		swap_slots(from_index, to_index)
	
	#inventory[to_index] = to_slot
	on_inventory_changed.emit()
#endregion

#region Equip Item
func equip_item(slot_index: int) -> void:
	var slot: SlotData = get_slot(slot_index)
	if not slot: return
	if not slot.item is EquipmentData: return
	
	var item: EquipmentData = slot.item as EquipmentData
	var equip_key: String = item.get_equip_key()
	var equiped_item: EquipmentData = GameData.equipment[equip_key]
	GameData.equipment[equip_key] = item
	inventory[slot_index] = null
	if equiped_item:
		add_item(equiped_item, 1)
	
	on_inventory_changed.emit()
	on_equipment_changed.emit()

func unequip_item(equip_type: EquipmentData.EquipmentType) -> void:
	var equip_key: String = GameData.equipment.keys()[equip_type]
	var equipped_item = GameData.equipment[equip_key]
	
	if not equipped_item: return
	
	add_item(equipped_item, 1)
	GameData.equipment[equip_key] = null
	on_equipment_changed.emit()
#endregion

#region Use Item
func use_item(slot_index: int) -> void:
	var slot: SlotData = inventory[slot_index]
	if not slot:
		return
	if not slot.item.is_consumable:
		return
	
	slot.quantity -= 1
	
	if slot.quantity <= 0:
		inventory[slot_index] = null
	
	on_inventory_changed.emit()


func can_use_item(slot_index: int) -> bool:
	var slot: SlotData = get_slot(slot_index)
	return slot and slot.item.is_consumable
#endregion
