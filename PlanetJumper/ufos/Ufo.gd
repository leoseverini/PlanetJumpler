extends Area2D
var maxUfos = 2
var pos =  -100
var vel = 0
var mov = 0
var ufoVelocity = 1

func setMovement(m):
	mov = m

func setVelocity(v):
	vel = v
	
func _ready():
	position.y = pos
	position.x = -100
	ufoVelocity = rand_range(0.5, 2)
	$AnimatedSprite.frame = randi() % maxUfos
	
func move():
	pos = pos + vel
	position.y = pos
	position.x = position.x + mov + ufoVelocity
	if position.y > 1000:
		print(" Ufo Deleted")
		queue_free()