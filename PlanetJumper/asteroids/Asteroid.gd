extends Node2D

var maxAsteroids = 5
var pos =  -100
var vel = 0
var mov = 0
var rotationSpeed = 0.01
var inVel = 0 # EL Y
var inMov = 0 # EL X
var wasCrashed = false

signal shipCrashed()

func _ready():
	position.y = pos
	position.x = rand_range(100, 500)
	$Asteroid/AnimatedSprite.frame = randi() % maxAsteroids
	rotationSpeed = rand_range(0.01, 0.1)
	
	inVel = rand_range(0.5, 2)
	inMov = rand_range(-6, 6)
	
	var scl = rand_range(0.2, 1)
	scale = Vector2(scl, scl)


func _process(delta):
	pass

func move():
	$Asteroid.rotate(rotationSpeed)
	pos = pos + vel + inVel
	position.y = pos
	position.x = position.x + mov + inMov
	if position.y > 1000:
		print(" Asteroid Deleted")
		queue_free()
		
func setMovement(m):
	mov = m

func setVelocity(v):
	vel = v


func get_inMov():
	return inMov

func get_inVel():
	return inVel
	
func _on_Area2D_area_entered(area):
	if "Asteroid" in area.get_name():
		if !wasCrashed:
			rotationSpeed = -rotationSpeed
			var t = inMov 
			inMov = area.get_parent().inMov
			area.get_parent().inMov = t
			
			t = inVel
			inVel = area.get_parent().inVel
			area.get_parent().inVel = t
						
			area.get_parent().wasCrashed = true
		else:
			wasCrashed = false
	else: 
		emit_signal("shipCrashed")

