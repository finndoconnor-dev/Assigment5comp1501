extends MoveableObject

signal turn_end  # emitted when player finishes move

var is_moving: bool = false
var can_move: bool = true

func _process(delta: float) -> void:
	if not can_move or is_moving:
		return

	var dir = Vector2.ZERO
	if Input.is_action_just_pressed("w"):
		dir = Vector2.UP
	elif Input.is_action_just_pressed("s"):
		dir = Vector2.DOWN
	elif Input.is_action_just_pressed("a"):
		dir = Vector2.LEFT
	elif Input.is_action_just_pressed("d"):
		dir = Vector2.RIGHT

	if dir != Vector2.ZERO:
		if move(dir):
			is_moving = true
			can_move = false
			emit_signal("turn_end")  # kids will move next
