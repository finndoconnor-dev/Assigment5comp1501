extends MoveableObject
# Imported variables
@onready var score_text: Label = $"../../Hud/ScoreText"
@onready var move_timer: Timer = $MoveTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_timer: Timer = $AnimationTimer
@onready var captured_sfx: AudioStreamPlayer2D = $CapturedSfx
# Signals
signal captured
signal kid_turn_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("kid")

# boolean flags for moving
var is_moving = false
var can_move = false

# physics process called every frame, used for moving sprite to desired tile
func _physics_process(delta: float) -> void:
	
	
	# if currently moving return
	if is_moving == false:
		return
	
	# If the global position is the same as current sprite position then set moving to false
	if global_position == sprite_2d.global_position:
		is_moving = false
		kid_turn_finished.emit()
		return
	
	# Move the sprite towards the global position at speed of 5
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# variables for random movement
var last_dir = 0
var random_dir = 0
var directions = [Vector2(0, -2), Vector2(0, 2), Vector2(-2, 0), Vector2(2, 0)]

func move_in_random_direction() -> void:
	# return if its moveing
	if is_moving:
		return
	
	# While loop to generate a valid move, and then check if its valid
	while true:
		random_dir = randi_range(0, 3)
		
		# if the random direction is the same as the last selected direction generate a new number
		if random_dir == last_dir:
			continue
		# if the random direction is the opposite of the last selected direction generate a new number, makes it so they don't back track
		elif -directions[random_dir] == directions[last_dir]:
			continue
		else:
			break
	
	# Call is_moving to move the piece
	is_moving = move(directions[random_dir])
	
	# if the move was sucessful make the last direction the latest random direction
	if is_moving:
		last_dir = random_dir

# When the player turn ends allow for movement
func _on_player_turn_end() -> void:
	move_timer.start()

# When the area 2d has been entered, emit captured and play animation and soundfx
func _on_area_2d_area_entered(area: Area2D) -> void:
	captured.emit()
	animation_player.play("captured")
	captured_sfx.play()
	# Start animation timer so that animation has time to play
	animation_timer.start()

# Move in a random direction after the move timer has ran out
func _on_move_timer_timeout() -> void:
	move_in_random_direction()

# End the kids turn once captured, and remove it from the scene tree
func _on_animation_timer_timeout() -> void:
	kid_turn_finished.emit()
	queue_free()
