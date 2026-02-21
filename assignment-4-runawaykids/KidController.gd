extends Node

@export var kid_scene: PackedScene   # drag your Kid.tscn here
@export var player: Node                 # drag the Player node here
@export var grid_size: Vector2 = Vector2(5, 5)
@export var tile_spacing: int = 130
@export var start_position: Vector2 = Vector2(230, 230)

var kids: Array = []

func _ready() -> void:
	if kid_scene == null:
		push_error("Kid scene not assigned!")
		return
	if player == null:
		push_error("Player node not assigned!")
		return

	_spawn_kids()
	_connect_kids_to_player()

func _spawn_kids() -> void:
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var kid = kid_scene.instantiate()
			add_child(kid)
			kids.append(kid)

			# position in a grid
			kid.global_position = start_position + Vector2(x, y) * tile_spacing

func _connect_kids_to_player() -> void:
	for kid in kids:
		# connect player turn_end to kid
		if not player.is_connected("turn_end", Callable( kid, "on_player_turn_end")):
			player.connect("turn_end", Callable(kid, "on_player_turn_end"))

		# connect kid turn_end to player
		if not kid.is_connected("turn_end", Callable(player, "_on_kid_turn_end")):
			kid.connect("turn_end", Callable(player, "_on_kid_turn_end"))
