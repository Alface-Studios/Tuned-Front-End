extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var music_position = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music(pos):
	$AnimationPlayer.play("fade_in")
	self.play(pos)

func play_button():
	$button.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func stop_music():
	$AnimationPlayer.play("fade_out")



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		self.stop()
