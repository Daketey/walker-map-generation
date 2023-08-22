extends Node2D

var borders = Rect2(1, 1, 38, 21)

@onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(200)
	
	walker.queue_free()
	var cells = []
	for location in map:
		cells.append(location)
	tileMap.set_cells_terrain_connect(0, cells, 0, 0, false)
	
func reload_level():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
