extends CanvasLayer

onready var player = get_tree().get_root().get_node("World").get_node("Player")
onready var label = $Label

func _process(delta):
	label.text = "Accelerometer: "+str(Input.get_accelerometer().x)+"\nRespawn Holder: "+str(player.respawn_holder)+"\nKeys: "+str(player.keys)+"\nSavedKeys: "+str($"/root/Global".savedkeys)
	