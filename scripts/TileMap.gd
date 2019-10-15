extends TileMap

func _ready():
	var spikes = get_used_cells_by_id(1)
	for spike in spikes:
		var spikeArea = load("res://objects/SpikeArea.tscn").instance()
		spikeArea.position = spike*16
		$SpikeAreas.add_child(spikeArea)
	
	var lavas = get_used_cells_by_id(3)
	for lava in lavas:
		var lavaArea = load("res://objects/LavaArea.tscn").instance()
		lavaArea.position = lava*16
		$KillAreas.add_child(lavaArea)
