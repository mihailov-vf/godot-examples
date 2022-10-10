extends TileMap

const BOARD_LAYER = 0
const MOVEMENT_LAYER = 1

func _ready():
	for child in get_children():
		set_cell(MOVEMENT_LAYER, local_to_map(child.position), 1)

func move(object: Node2D, direction: Vector2i):
	var cell_start = local_to_map(object.position)
	var cell_target = cell_start + direction
	
	return update_position(object, cell_start, cell_target)

func update_position(object: Node2D, cell_start: Vector2i, cell_target: Vector2i) -> Vector2:
	set_cell(MOVEMENT_LAYER, cell_target, 1)
	set_cell(MOVEMENT_LAYER, cell_start, 0)
	if self.get_cell_tile_data(BOARD_LAYER,cell_target).get_custom_data("Type") == 3:
		return object.position
	print_debug("Moving player to: ", cell_target, " -> ", self.get_cell_tile_data(BOARD_LAYER,cell_target).get_custom_data("Type"))
	return map_to_local(cell_target)
