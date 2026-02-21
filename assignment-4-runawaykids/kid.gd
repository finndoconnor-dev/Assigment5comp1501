extends MoveableObject

signal turn_end
signal captured

var is_moving: bool = false
var last_dir: int = -1
var directions: Array = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func on_player_turn_end() -> void:
	move_randomly()

func move_randomly() -> void:
	if is_moving:
		return

	var tries = 0
	while tries < 10:
		var dir_index = randi() % directions.size()
		var dir = directions[dir_index]

		# avoid repeating same direction
		if dir_index == last_dir:
			tries += 1
			continue

		if move(dir):
			last_dir = dir_index
			is_moving = true
			break
		tries += 1

	emit_signal("turn_end")  # notify player

func _physics_process(delta: float) -> void:
	if not is_moving:
		return
	# simple movement animation toward global_position
	Sprite2D.global_position = Sprite2D.global_position.move_toward(global_position, 5)
	if Sprite2D.global_position == global_position:
		is_moving = false

func _on_area_entered(area: Area2D) -> void:
	emit_signal("captured")
	queue_free()
