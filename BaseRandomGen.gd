extends Node2D

#var borders = Rect2(1, 1, 38, 21)

@onready var tileMap = $TileMap

var borders = Rect2(1, 1 , 38, 21)

func _ready():
	randomize()
	generate_level()


func generate_level():

	
	var walker = Walker.new(Vector2(1, 1), borders, tileMap)
	var map = walker.walk(600)
	var starting_postiion = map.front()
	var end_position = walker.get_end_room().position
	walker.queue_free()
	tileMap.set_cells_terrain_connect(0, map, 0, -1)
	
	
func reload_level():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
