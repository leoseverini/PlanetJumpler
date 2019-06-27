extends Area2D

signal move(x)
signal velocity(v)
signal fuel(f)

var vel = 1
var steps = 0.05
var crashed = false
var fuelAmount = 100
var deltaSum = 0
var fuelConsume = 0.02

func _ready():
	pass # Replace with function body.


func _process(delta):
	deltaSum = deltaSum + delta
	if deltaSum >= 0.0167:
		deltaSum = 0
		
		if !crashed and Input.is_mouse_button_pressed(BUTTON_LEFT):
			vel = min(2, vel + steps)
		else:
			vel = max(0, vel - steps)
		
		var scl = map(vel, 0,2, 0.5, 1)
		
		get_node(".").scale = Vector2(scl, scl)
		
		fuelAmount = max(0, fuelAmount - (vel * fuelConsume))
		
		emit_signal("velocity", vel)
		emit_signal("fuel", fuelAmount)
	
func _input(event):
	var rot = 0.0
	if event is InputEventMouseMotion:
		if !crashed and Input.is_mouse_button_pressed(BUTTON_LEFT):
			var p = -(event.position.x - 300) / 50
			rot = map(p, -6, 6, -1,1)
			emit_signal("move", -p)
		else:
			emit_signal("move", 0)
		
		rotation = rot
		
func crash():
	print("Ship Crashed")
	crashed = true
	$AnimationPlayer.play("explode")

func map( value,  istart,  istop,  ostart, ostop):
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));

func addFuel(amount):
	fuelAmount = fuelAmount + amount