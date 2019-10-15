extends Node2D

var activated = false


onready var player = get_tree().get_root().get_node("World").get_node("Player")

func _ready():
	add_to_group("checkpoint_group")
	pass

func _process(delta):
	
	if activated :
		$Label.show()
	else:
		$Label.hide()

func _on_Area2D_body_entered(body):
	if body == player:
		var checkpoints = get_tree().get_nodes_in_group("checkpoint_group")
		for checkpoint in checkpoints:
			if checkpoint.activated == true && checkpoint != self:
				checkpoint.activated = false
		
		var doors = get_tree().get_nodes_in_group("door_group")
		for door in doors:
			if door.activated && !door.insured:
				door.insured = true
				
		var keys = get_tree().get_nodes_in_group("key_group")
		for key in keys:
			if key.activated && !key.insured:
				key.insured = true
				
		player.checkpoint_coord = position
		$"/root/Global".savedkeys = player.keys
		activated = true
		

	
	