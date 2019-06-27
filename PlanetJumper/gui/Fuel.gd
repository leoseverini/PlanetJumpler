extends Control

var fuel = 0.0 

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func fuel_set(val):
	fuel = max(0, min(100, val))
	
	if fuel < 30 and fuel >= 10:
		$full.visible = false
		if $blinkTimer.is_stopped():
			$off.visible = true
			$blinkTimer.start(0.5)
	elif fuel < 10:
		$blinkTimer.stop()
		$full.visible = false
		$off.visible = false
		$empty.visible = true
	else:
		$full.visible = true
		$off.visible = false
		$empty.visible = false
	
	setMeter()
	
func setMeter():
	var rot = lerp(-90, 90, (fuel/100.0))
	$meter.rotation_degrees = rot


func _on_blinkTimer_timeout():
	$full.visible = false
	$off.visible = !$off.visible
	$empty.visible = !$off.visible