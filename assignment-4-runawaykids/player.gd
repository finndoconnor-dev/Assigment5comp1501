extends MoveableObject

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# boolean flag for moving
var is_moving = false
# Signal for turn_end
signal turn_end
# Store the amount of kid turns
var active_kid_turns = 0

# physics process called every frame, used for moving sprite to desired tile
func _physics_process(delta: float) -> void:

	# if currently moving return
	if is_moving == false:
		return
	
	# If the global position is the same as current sprite position then set moving to false
	if global_position == sprite_2d.global_position:
		# Emit turn end signal
		turn_end.emit()
		# Call the player turn end method for each node in the kid group
		get_tree().call_group("kid", "_on_player_turn_end")
		
		# Set is moving to false to allow player to move agin
		is_moving = false
		
		# Add 1 to active kid turns for every kid in the kid group, and call on each kids _on_player_turn_end function
		for kid in get_tree().get_nodes_in_group("kid"):
			active_kid_turns += 1
			kid._on_player_turn_end()
		return
	
	# Move the sprite towards the global position at speed of 5
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 5)

# Variable to see if the player can move
var can_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# If the player is moving or can't move return
	if is_moving:
		return
	
	if !can_move:
		return
	
	# Use Call move using the up down left right vectors
	if Input.is_action_pressed("up"):
		is_moving = move(Vector2.UP)
		can_move = false
	elif Input.is_action_pressed("down"):
		is_moving = move(Vector2.DOWN)
		can_move = false
	elif Input.is_action_pressed("left"):
		is_moving = move(Vector2.LEFT)
		can_move = false
	elif Input.is_action_pressed("right"):
		is_moving = move(Vector2.RIGHT)
		can_move = false

#When the start button is pressed set can_move to true
func _on_game_started():
	can_move = true
