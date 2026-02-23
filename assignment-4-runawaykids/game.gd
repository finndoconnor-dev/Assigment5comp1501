extends Node
# Imported varaibles
@onready var game_end_timer: Timer = $GameEndTimer
@onready var start_button = $Hud/StartButton
@onready var player: Sprite2D = $Camera2D/Player


# Called when the node enters the scene tree for the fidrst time.
func _ready() -> void:
	# Connect signals
	start_button.start.connect(player._on_game_started)
	for kid in get_tree().get_nodes_in_group("kid"):
		kid.kid_turn_finished.connect(_on_kid_finished)

var game_end = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check every frame to see if all kids are gone if so restart the game
	if !game_end and get_tree().get_nodes_in_group("kid").is_empty():
		game_end = true
		game_end_timer.start()

# When a kid's turn finished decrease the active kid turns counter, once its 0 allow the player to move
func _on_kid_finished():
	player.active_kid_turns -= 1
	
	if player.active_kid_turns <= 0:
		player.can_move = true

# When the turn limit is reached end the game
func _on_hud_turn_limit() -> void:
	game_end_timer.start()

# Reload the scene once the timer runs out
func _on_game_end_timer_timeout() -> void:
	get_tree().reload_current_scene()
