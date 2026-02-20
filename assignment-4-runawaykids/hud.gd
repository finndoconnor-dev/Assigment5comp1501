extends CanvasLayer
var turn=0
var score=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_turn_end() -> void:
	turn+=1
	$TurnCount.text= "Turn: " + str(turn)


func _on_kid_captured() -> void:
	score+=1
	$ScoreText.text="Score: " + str(score)
