extends Area2D

onready var player = get_tree().get_root().get_node("World").get_node("Player")
 

func _on_LavaArea_body_entered(body):
	
	if body == player:
		player.kill()
