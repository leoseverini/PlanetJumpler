extends Node2D

var planet_resource = preload("res://items/planets/planet.tscn")
var asteroid_resource = preload("res://items/asteroids/Asteroid.tscn")
var ufo_resource = preload("res://items/ufos/Ufo.tscn")

var distance = 0
var shipX = 0
var shipV = 0

var nextPlanetDistance = 1000
var nextAsteroidDistance = 800
var nextUfoDistance = 1200

var asteroidDistance = 0
var ufoDistance = 0

var isGameOver = false
var deltaSum = 0

func _ready():
	nextPlanetDistance = rand_range(500, 1500)
	nextAsteroidDistance = rand_range(500, 1500)
	nextUfoDistance = rand_range(500, 1500)
	addPlanet()
	addAsteroid()
	addUfo()

func _process(delta):
	deltaSum = deltaSum + delta
	if deltaSum >= 0.02:
		deltaSum = 0
		sceneMove()
	
func _on_Ship_move(x):
	shipX = x
	
func _on_Ship_velocity(v):
	shipV = v
	distance = distance + v
	asteroidDistance = asteroidDistance + v
	ufoDistance = ufoDistance + v
	
	if distance > nextPlanetDistance:
		distance = 0
		nextPlanetDistance = rand_range(300, 600)
		addPlanet()
	
	if asteroidDistance > nextAsteroidDistance:
		asteroidDistance = 0
		nextAsteroidDistance =  rand_range(10, 200)
		addAsteroid()
		
	if ufoDistance > nextUfoDistance:
		ufoDistance = 0
		nextUfoDistance = rand_range(600, 1200)
		addUfo()

func _input(event):
	# if event is InputEventKey:
	#	$Ship.crash()	
	pass
		
func addPlanet():
	# print("ADD PLANET")
	var planet = planet_resource.instance()	
	planet.z_index = 1
	planet.connect("planetEnter", self, "_on_Planet_Enter")
	add_child(planet)
	
func addAsteroid():
	# print("ADD ASTEROID")
	var asteroid = asteroid_resource.instance()	
	asteroid.z_index = 2
	asteroid.connect("shipCrashed", self, "_on_Ship_Chrashed")
	add_child(asteroid)

func addUfo():
	# print("ADD UFO")
	var ufo = ufo_resource.instance()	
	ufo.z_index = 3
	# ufo.connect("planetEnter", self, "_on_Planet_Enter")
	add_child(ufo)	
	
func sceneMove():
	$ParallaxBackground/ParallaxLayer.motion_offset.x = $ParallaxBackground/ParallaxLayer.motion_offset.x + (shipX * 0.8)
	$ParallaxBackground/ParallaxLayer.motion_offset.y = $ParallaxBackground/ParallaxLayer.motion_offset.y + (shipV * 0.8)
	
	$ParallaxBackground/ParallaxLayer2.motion_offset.x = $ParallaxBackground/ParallaxLayer2.motion_offset.x + (shipX * 1.8) + 0.5
	$ParallaxBackground/ParallaxLayer2.motion_offset.y = $ParallaxBackground/ParallaxLayer2.motion_offset.y + (shipV * 1.8) + 0.5
	
	for obj in get_children():
		if "Planet" in obj.get_name() or "Asteroid" in obj.get_name() or "Ufo" in obj.get_name():
			obj.setMovement(shipX)
			obj.setVelocity(shipV)
			obj.move()

func _on_Ship_Chrashed():
	isGameOver = true
	# $Ship.crash()

func _on_Ship_fuel(f):
	$GuiLayer/GUI/FuelMeter.fuel_set(f)
	
func _on_Planet_Enter(planet):
	if shipV == 0:
		var collectVelocity = 0.05
		planet.collectResources(collectVelocity)
		$Ship.addFuel(collectVelocity)
