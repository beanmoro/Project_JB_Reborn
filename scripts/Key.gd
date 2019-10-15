extends Sprite

var activated = false

onready var player = get_tree().get_root().get_node("World").get_node("Player")

var insured = false

func _ready():
	add_to_group("key_group")

func _process(delta):
	
	if activated:
		hide()
	else:
		show()

func _on_Area2D_body_entered(body):
	if body == player && !activated:
		player.keys+=1
		activated = true

func repos():
	activated = false