extends MoveableObject
#boolean to check if game is over
var game_over=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")

# boolean flag for moving
var is_moving = false
signal turn_end

# physics process called every frame, used for moving sprite to desired tile
func _physics_process(delta: float) -> void:
	if (game_over):
		return
	# if currently moving return
	if is_moving == false:
		return
	
	# If the global position is the same as current sprite position then set moving to false
	if global_position == sprite_2d.global_position:
		turn_end.emit()
		get_tree().call_group("kid", "_on_player_turn_end")
		is_moving = false
		return
	
	# Move the sprite towards the global position at speed of 5
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 5)

var can_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
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

func _on_kid_turn_end():
	can_move = true

func _on_start_button_start():
	game_over=false
	can_move = true


func _on_hud_turn_limit() -> void:
	can_move=false
	game_over=true
	move_to_start(Vector2(0,0))
