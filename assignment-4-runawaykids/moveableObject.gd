extends Node2D
class_name MoveableObject

@onready var sprite: Sprite2D = $Sprite2D
@onready var tile_map: TileMap = get_parent().get_node("TileMap")  # path to TileMap

# move in a direction, returns true if move is valid
func move(direction: Vector2) -> bool:
	if tile_map == null:
		push_error("TileMap not found!")
		return false

	var current_tile = tile_map.world_to_map(global_position)
	var target_tile = current_tile + Vector2i(int(direction.x), int(direction.y))

	# check if tile is walkable
	var cell_id = tile_map.get_cell_terrain(target_tile.x, target_tile.y)
	if cell_id == -1:
		return false

	# move
	global_position = tile_map.map_to_world(target_tile)
	sprite.global_position = global_position  # start sprite at new logical position
	return true
