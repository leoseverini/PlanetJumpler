extends "res://items/SpaceItem.gd"

var wasCrashed = false

signal shipCrashed()

func _ready():
	maxItem = 5
	position.y = pos
	position.x = rand_range(100, 500)
	$Asteroid/AnimatedSprite.frame = randi() % maxItem
	rotationSpeed = rand_range(0.01, 0.1)
	
	inVel = rand_range(0.5, 2)
	inMov = rand_range(-6, 6)
	
	var scl = rand_range(0.2, 1)
	scale = Vector2(scl, scl)


func _process(delta):
	pass

func customMove():
	$Asteroid.rotate(rotationSpeed)
	pass
	
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
