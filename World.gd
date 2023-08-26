extends Node2D

#var borders = Rect2(1, 1, 38, 21)

@onready var tileMap = $TileMap

var all_rooms = []

func _ready():
	seed(1)
	generate_level()


func generate_level():
	var map_details = {}
	var selected_cells = {}
#	var al_room = []
	for h in range(1, 3+1):
#		randomize()
		
		var start1 = h*(randi()%4+1)
		var start2 = h*(randi()%4+1)
		var borders = Rect2(start1, start2 , 30 + randi()%4, 20+randi()%3)
		var walker = Walker.new(Vector2(start1, start2), borders, tileMap)
		var map = walker.walk(600)
		var starting_postiion = map.front()
		var end_position = walker.get_end_room().position
		walker.queue_free()
		for r in map:
			map_details[r] = {
						"left": false, 
						"right": false,
						"up": false, 
						"down": false
						}
		tileMap.set_cells_terrain_connect(0, map, 0, -1)
		var rooms = walker.return_rooms()
		for room in rooms:
			for r in room.room:
				if randi()%2 == 1:
					selected_cells[r] = 1 #Select Cells randomly
		
		var al = walker.get_rooms()
		var count = 0
		var al_room = []
		for room in al:
			al_room.append(room.position)
		
		# can be done better with graph traversal
		
		print(al_room)
		for i in range(al_room.size()+1):
			if al_room[i].x ==  al_room[i+1].x:
				for j in range(al_room[i].y, al_room[i+1].y+1):
					var erase_y = Vector2(al_room[i].x, j)
					al_room.append(erase_y)
			if al_room[i].y ==  al_room[i+1].y:
				for j in range(al_room[i].x, al_room[i+1].x+1):
					var erase_x = Vector2(j, al_room[i].y)
					al_room.append(erase_x)
			
		for i in al_room:
			selected_cells[i] = 0
		
#		tileMap.set_cells_terrain_connect(0, al_room, 0, -1)
		
		tileMap.set_cell(0, starting_postiion, 3, Vector2(14 , 4)) #use this somehow	
		tileMap.set_cell(0, end_position, 3, Vector2(12 , 4)) #use this somehow
		
#	for i in [Vector2(11, 14),Vector2(12, 14),Vector2(10, 14),Vector2(11, 13),Vector2(11, 15)]:
#		tileMap.set_cell(0, i, 3, Vector2(12 , 7))
#	tileMap.set_cell(0, Vector2(11, 14), 3, Vector2(4 , 6))
#	tileMap.set_cells_terrain_connect(0, map_details.keys(), 0, -1) #TO Debug map creation
#	for selected_cell in selected_cells.keys():
#		tileMap.set_cell(0, selected_cell, 3, Vector2(9 , 8)) #use this somehow	
#	tileMap.set_cells_terrain_connect(0, al_room, 0, -1)
	
	for i in selected_cells.keys():
		if selected_cells[i] == 1:
			tileMap.set_cell(0, i, 3, Vector2(9 , 8))
	
	for cell in map_details.keys():
		var up = Vector2(cell.x, cell.y-1)
		var down = Vector2(cell.x, cell.y+1)
		var left = Vector2(cell.x - 1, cell.y)
		var right = Vector2(cell.x + 1, cell.y)
		if up in selected_cells and selected_cells[up] == 1:
			map_details[cell].up = true
		if down in selected_cells and selected_cells[down] == 1:
			map_details[cell].down = true 
		if left in selected_cells and selected_cells[left] == 1:
			map_details[cell].left = true 
		if right in selected_cells and selected_cells[right] == 1:
			map_details[cell].right = true 
				
	for i in map_details.keys():
		if (map_details[i].left and map_details[i].right) and map_details[i].down and not map_details[i].up:
#			tileMap.set_cell(0, i, 3, Vector2(12 , 7))
			pass
		# ###########################################################################
		# #Compare all 3 starting position to their end position, take the best past#
		# ###########################################################################
#	const arr = [Vector2(15, 6), Vector2(9, 6), Vector2(9, 12), Vector2(15, 12), Vector2(9, 12), Vector2(9, 18), Vector2(15, 18), Vector2(15, 12), Vector2(9, 12), Vector2(15, 12), Vector2(15, 18), Vector2(21, 18), Vector2(21, 24), Vector2(15, 24), Vector2(15, 27), Vector2(21, 27), Vector2(15, 27), Vector2(15, 21), Vector2(9, 21), Vector2(15, 21), Vector2(15, 15), Vector2(9, 15), Vector2(9, 9), Vector2(9, 15), Vector2(9, 9), Vector2(9, 15), Vector2(15, 15), Vector2(15, 21), Vector2(15, 15), Vector2(15, 21), Vector2(21, 21), Vector2(21, 27), Vector2(27, 27), Vector2(27, 21), Vector2(27, 27), Vector2(33, 27), Vector2(33, 21), Vector2(39, 21), Vector2(39, 15), Vector2(33, 15), Vector2(33, 21), Vector2(27, 21), Vector2(27, 15), Vector2(33, 15), Vector2(27, 15), Vector2(27, 9), Vector2(27, 15), Vector2(27, 9), Vector2(27, 15), Vector2(21, 15), Vector2(21, 21), Vector2(15, 21), Vector2(15, 27), Vector2(15, 21), Vector2(9, 21), Vector2(9, 15), Vector2(9, 21), Vector2(9, 15), Vector2(9, 21), Vector2(9, 15), Vector2(15, 15), Vector2(9, 15), Vector2(9, 9), Vector2(15, 9), Vector2(9, 9), Vector2(15, 9), Vector2(15, 15), Vector2(21, 15), Vector2(21, 21), Vector2(15, 21), Vector2(21, 21), Vector2(21, 15), Vector2(27, 15), Vector2(27, 21), Vector2(33, 21), Vector2(33, 27), Vector2(33, 21), Vector2(27, 21), Vector2(27, 15), Vector2(27, 21), Vector2(27, 15), Vector2(27, 21), Vector2(33, 21), Vector2(33, 27), Vector2(33, 21), Vector2(39, 21), Vector2(39, 15), Vector2(39, 21), Vector2(41, 21), Vector2(41, 15), Vector2(41, 21), Vector2(35, 21), Vector2(35, 15), Vector2(41, 15), Vector2(35, 15), Vector2(35, 9), Vector2(35, 15), Vector2(41, 15), Vector2(41, 21), Vector2(41, 15)]
#	for i in arr:
#		tileMap.set_cell(0, i, 3, Vector2(12 , 7))
		
		
func build_graph(edges):
	var graph = {}
	for edge in edges:
		var a = edge.x
		var b = edge.y
		if not a in graph:
			graph[a] = []
		if not b in graph:
			graph[b] = []
		graph[a].append(b)
		graph[b].append(a)
		
	return graph
	
func reload_level():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
