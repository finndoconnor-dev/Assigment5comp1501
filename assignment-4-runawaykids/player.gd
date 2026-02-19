extends MoveableObject
signal turn_end
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# boolean flag for moving
var is_moving = false

# physics process called every frame, used for moving sprite to desired tile
func _physics_process(delta: float) -> void:
	
	# if currently moving return
	if is_moving == false:
		return
	
	# If the global position is the same as current sprite position then set moving to false
	if global_position == sprite_2d.global_position:
		turn_end.emit()
		is_moving = false
		return
	
	# Move the sprite towards the global position at speed of 5
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# return if its moveing
	if is_moving:
		return
	
	# Use Call move using the up down left right vectors
	if Input.is_action_pressed("up"):
		is_moving = move(Vector2.UP)
	elif Input.is_action_pressed("down"):
		is_moving = move(Vector2.DOWN)
	elif Input.is_action_pressed("left"):
		is_moving = move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		is_moving = move(Vector2.RIGHT)
