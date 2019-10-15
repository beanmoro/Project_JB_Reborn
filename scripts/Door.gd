extends StaticBody2D

var origin = Vector2()
export(Vector2) var destination = Vector2()
export var activated = false
var speed = 60
onready var player = get_tree().get_root().get_node("World").get_node("Player")
var insured = false

func _ready():
	add_to_group("door_group")
	origin = position
	
func _process(delta):
	if activated && position.distance_to(destination) > 1:
		$CollisionShape2D.disabled = true
		
		if abs(position.x-destination.x) > 1:
			if position.x < destination.x:
				position.x += speed * delta
			elif position.x > destination.x:
				position.x -= speed *delta
		else:
			position.x = destination.x
		
		if abs(position.y-destination.y) > 1:
			if position.y < destination.y:
				position.y += speed * delta
			elif position.y > destination.y:
				position.y -= speed * delta
		else:
			position.y = destination.y
			
	elif position.distance_to(destination) < 1 && $CollisionShape2D.disabled:
		position = destination
		$CollisionShape2D.disabled = false

func _on_KeyArea_body_entered(body):
	if body == player && player.keys > 0 && !activated:
		player.keys -= 1
		activated = true

func repos():
	position = origin
	activated = false
