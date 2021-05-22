extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal dock

var entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(_delta):
	if entered and Input.is_action_just_released("left_click") and Global.mode != "talk":
		emit_signal("dock", self.animation, self, self.position)
		entered = false
		

func _on_Area2D_area_entered(_area):
	entered = true


func _on_Area2D_area_exited(_area):
	entered = false
