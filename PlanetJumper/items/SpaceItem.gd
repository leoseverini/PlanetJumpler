extends Node2D

var maxItem = 5
var pos =  -150
var vel = 0
var mov = 0
var rotationSpeed = 0
var inVel = 0 # EL Y
var inMov = 0 # EL X

func _ready():
	pass

func _process(delta):
	pass

func customMove():
	pass
	
func move():
	customMove()
	pos = pos + vel + inVel
	position.y = pos
	position.x = position.x + mov + inMov
	if position.y > 1200:
		# print(" Item Deleted")
		queue_free()

func setMovement(m):
	mov = m

func setVelocity(v):
	vel = v
