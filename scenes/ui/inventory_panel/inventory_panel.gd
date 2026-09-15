extends PanelContainer
class_name InventoryPanel

@onready var container: GridContainer = %Container
@onready var gold_label: Label = %GoldLabel

var slots: Array[InventorySlot]

func _ready() -> void:
	Inventory.on_inventory_changed.connect(_on_inventory_changed)
	for i in container.get_child_count():
		var slot: InventorySlot = container.get_child(i)
		slot.on_slot_click.connect(_on_slot_click)
		slot.on_slot_hover.connect(_on_slot_hover)
		slot.slot_index = i
		slots.append(slot)
		

func _on_inventory_changed() -> void:
	for i in slots.size():
		var slot: SlotData = Inventory.get_slot(i)
		slots[i].load_data(slot)

func _on_slot_click() -> void:
	print("SLOT_CLICKED")

func _on_slot_hover() -> void:
	print("SLOT_HOVER")
