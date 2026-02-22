extends CanvasLayer
var turn=0
var score=0
signal turn_limit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	turn_limit_reached()


func _on_player_turn_end() -> void:
	turn+=1
	$TurnCount.text= "Turn: " + str(turn)

func update_score() -> void:
	score+=1
	$ScoreText.text="Score: " + str(score)
	
func _on_kid_captured() -> void:
	update_score()

func turn_limit_reached():
	if turn>=15:
		score=0
		$ScoreText.text="Score: " + str(score)
		turn=0
		$TurnCount.text= "Turn: " + str(turn)
		turn_limit.emit()
		$StartButton.show()


func _on_kid_2_captured() -> void:
	update_score()

func _on_kid_3_captured() -> void:
	update_score()

func _on_kid_4_captured() -> void:
	update_score()

func _on_kid_5_captured() -> void:
	update_score()


func _on_kid_6_captured() -> void:
	update_score()


func _on_kid_7_captured() -> void:
	update_score()


func _on_kid_8_captured() -> void:
	update_score()


func _on_kid_9_captured() -> void:
	update_score()
