extends MoveableObject

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
		is_moving = false
		return
	
	

var last_dir = 0
var random_dir = 0
var directions = [Vector2(0, -2), Vector2(0, 2), Vector2(-2, 0), Vector2(2, 0)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# return if its moveing
	if is_moving:
		return
	
	while true:
		random_dir = randi_range(0, 3)
		
		print("last_dir: " + var_to_str(last_dir))
		print("random_dir: " + var_to_str(random_dir), directions[random_dir], -directions[random_dir])
		if random_dir == last_dir:
			continue
		elif -directions[random_dir] == directions[last_dir]:
			continue
		else:
			break
	
	is_moving = move(directions[random_dir])
	
	if is_moving:
		last_dir = random_dir


func _on_player_turn_end() -> void:
	while (global_position!=sprite_2d.global_position):
		# Move the sprite towards the global position at speed of 5
		sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 5)
	is_moving=false
	return
