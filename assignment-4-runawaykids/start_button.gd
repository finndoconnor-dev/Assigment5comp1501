extends Button
signal start
@onready var player: Sprite2D = $"../../Camera2D/Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#hide itself after starting game
func _on_pressed() -> void:
	start.emit()
	hide()
	
	get_tree().call_group("player", "_on_start_button_start")
