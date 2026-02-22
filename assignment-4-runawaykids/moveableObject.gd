extends Node2D
class_name MoveableObject

@onready var tile_map_layer: TileMapLayer = $"../Grid/TileMapLayer"
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# function for logic of finding the next valid tile to mvoe to
func move(direction : Vector2):
	
	# get the current tile
	var current_tile: Vector2i = tile_map_layer.local_to_map(global_position)
	
	# calculate the target tile
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	# get the tile data of the target tile
	var tile_data: TileData = tile_map_layer.get_cell_tile_data(target_tile)
	
	# if the target tile does not exist or it's not walkable return
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return
	
	# turn vectors into tile map coordinates 
	global_position = tile_map_layer.map_to_local(target_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(current_tile)
	
	return true
	
func move_to_start(startingTile:Vector2):
	var current_tile: Vector2i = tile_map_layer.local_to_map(global_position)
	
	#moves object back to starting tile
	global_position = tile_map_layer.map_to_local(startingTile)
	sprite_2d.global_position = tile_map_layer.map_to_local(current_tile)
	sprite_2d.global_position=global_position
