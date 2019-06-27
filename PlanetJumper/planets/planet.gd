extends Area2D

var maxPlanets = 4
var pos =  -100
var vel = 0
var mov = 0
var onPlanet = false

signal planetEnter()

func setMovement(m):
	mov = m

func setVelocity(v):
	vel = v
	
func _ready():
	position.y = pos
	$Sprite2.visible = false
	position.x = rand_range(100, 500)
	$AnimatedSprite.frame = randi()%maxPlanets
	
	var scl = rand_range(0.5, 2)
	scale = Vector2(scl, scl)

func _process(delta):
	if onPlanet:
		emit_signal("planetEnter")	
	

func move():
	pos = pos + vel
	position.y = pos
	position.x = position.x + mov
	if position.y > 1000:
		print(" Planet Deleted")
		queue_free()
		
func _on_Planet_area_entered(area):
	$Sprite2.visible = true
	onPlanet = true
	print("Ship, enter")


func _on_Planet_area_exited(area):
	$Sprite2.visible = false
	onPlanet = false
	print("Ship, Exit")
