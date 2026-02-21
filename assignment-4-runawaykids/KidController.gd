extends Node

@onready var tile_map_layer: TileMapLayer = $"../Grid/TileMapLayer"

const KID_SCENE = preload("res://kid.tscn")
const gap=130
const initial=330
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnKids(5) #this number gets squared
	
func spawnKids(count: int):
	for i in range(count):
		for j in range(count):
			var newKid=KID_SCENE.instantiate()
			newKid.position=Vector2(i*gap+initial,j*gap+initial)
			add_child(newKid)
