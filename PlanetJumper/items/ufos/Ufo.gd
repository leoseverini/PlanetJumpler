extends "res://items/SpaceItem.gd"
	
func _ready():
	maxItem = 2
	position.y = pos
	position.x = -100
	inMov = rand_range(0.5, 2)
	$Ufo/AnimatedSprite.frame = randi() % maxItem
