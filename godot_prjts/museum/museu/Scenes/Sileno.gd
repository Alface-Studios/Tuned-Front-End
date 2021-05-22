extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2

# var b = "text"
var speed = Vector2(300, 0)

onready var scale_sileno = scale.x
var balc_final_x = 10000

var gatilho = false


func _input(_event):
	if Input.is_action_pressed("left_click"):
		if Global.mode != 'talk':
			$AnimationPlayer.play("walk")
			if get_global_mouse_position().x > self.position.x:
				self.scale.x = scale_sileno
			elif get_global_mouse_position().x < self.position.x:
					self.scale.x = -scale_sileno
				
	if Input.is_action_just_released("left_click"):
		gatilho = false
		Global.position = self.position

func _physics_process(delta):
	if Input.is_action_pressed("left_click") and Global.mode != 'talk':
		gatilho = true
		if get_global_mouse_position().x > self.position.x + 10 and self.position.x < balc_final_x:
			self.position += speed*delta
			
		elif get_global_mouse_position().x < self.position.x - 10:
				self.position -= speed*delta
		else:
			$AnimationPlayer.play("idle")




func _on_AnimationPlayer_animation_finished(_anim_name):
	if gatilho:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
