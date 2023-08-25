extends Node


var astar_grid = AStarGrid2D.new()
var grid_size = Vector2i(32,32)
var cell_size  = Vector2i(16,16)

func _ready():
	initialize_grid()

func initialize_grid():
	grid_size = grid_size
	astar_grid.size = grid_size
	astar_grid.cell_size = Vector2i(32,32)
	astar_grid.offset = cell_size / 2
	astar_grid.update()
