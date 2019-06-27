extends "res://items/SpaceItem.gd"
var onPlanet = false
var fuelLeft = 0
var capacity = 0

signal planetEnter(_planet)

func _ready():
	capacity = rand_range(10,40)
	fuelLeft = capacity
	$Title.visible = false
	$Percent.visible  = false
	
	maxItem = 4
	position.y = pos
	$Planet/Sprite2.visible = false
	position.x = rand_range(100, 500)
	$Planet/AnimatedSprite.frame = randi()%maxItem
	
	var scl = rand_range(0.5, 2)
	$Planet.scale = Vector2(scl, scl)

func _process(delta):
	if onPlanet:
		emit_signal("planetEnter", self)
		
func _on_Planet_area_entered(area):
	# $Planet/Sprite2.visible = true
	onPlanet = true
	print("Ship, enter " + str(capacity))

func _on_Planet_area_exited(area):
	# $Planet/Sprite2.visible = false
	onPlanet = false
	print("Ship, Exit")

func collectResources(collectVelocity):
	$Title.visible = true
	$Percent.visible  = true
	if(fuelLeft > 0):
		$Planet/Sprite2.visible = true
		fuelLeft = max(0, fuelLeft - collectVelocity)		
	else:
		fuelLeft = 0
		$Planet/Sprite2.visible = false
		$Title.set("custom_colors/font_color",Color(1,0,0))
		$Title.text = "NO MORE RESOURCES"
		$Percent.visible  = false
	
	refreshText()
	return fuelLeft

func refreshText():
	var s = str("%10.1f %%" % (100 * (fuelLeft/capacity)))
	$Percent.text = s