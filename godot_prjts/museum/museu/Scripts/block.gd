extends RigidBody2D


var instance

var building = false
var going_right = true
var base_position = Vector2()
var sway_amount = Vector2()
onready var tween = get_node("Tween")
var objPos = Vector2()
const GRAVITY = 10.0
var index = 0
var built = false
onready var dropSound = get_node("drop")
onready var destructionSound = get_node("destruction")


func _ready():

	pass


func _integrate_forces(state):

	if building:
		var object_position = state.get_transform()
		object_position.origin = objPos
		state.set_transform(object_position)

	if Input.is_action_pressed("drop") and building and Global.mode != 'talk':
		building = false
		tween.stop_all()
		gravity_scale = GRAVITY
		dropSound.play()


func base(sprite):
	match sprite:
		"base1":
			$AnimatedSprite.animation = "base1"
			$base11.set_deferred("disabled", false)
			$base12.set_deferred("disabled", false)
			$base13.set_deferred("disabled", false)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)	

		"base2":
			$AnimatedSprite.animation = "base2"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", false)
			$base22.set_deferred("disabled", false)
			$base23.set_deferred("disabled", false)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)	

		"base3":
			$AnimatedSprite.animation = "base3"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", false)
			$base32.set_deferred("disabled", false)
			$base33.set_deferred("disabled", false)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)



func initialize(pos, sway, blockIndex, sprite):

	match sprite:
		"centro1":
			$AnimatedSprite.animation = "centro1"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", false)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)

		"centro2":
			$AnimatedSprite.animation = "centro2"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", false)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)
			
		"centro3":
			$AnimatedSprite.animation = "centro3"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", false)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)
			
		"topo1":
			$AnimatedSprite.animation = "topo1"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", false)
			$topo12.set_deferred("disabled", false)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)
			
		"topo2":
			$AnimatedSprite.animation = "topo2"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", false)
			$topo31.set_deferred("disabled", true)
			$topo32.set_deferred("disabled", true)
			$topo33.set_deferred("disabled", true)
			
		"topo3":
			$AnimatedSprite.animation = "topo3"
			$base11.set_deferred("disabled", true)
			$base12.set_deferred("disabled", true)
			$base13.set_deferred("disabled", true)
#			$base21.set_deferred("disabled", true)
			$base22.set_deferred("disabled", true)
			$base23.set_deferred("disabled", true)
			$base31.set_deferred("disabled", true)
			$base32.set_deferred("disabled", true)
			$base33.set_deferred("disabled", true)
			$centro1.set_deferred("disabled", true)
			$centro2.set_deferred("disabled", true)
			$centro3.set_deferred("disabled", true)
			$topo11.set_deferred("disabled", true)
			$topo12.set_deferred("disabled", true)
			$topo21.set_deferred("disabled", true)
			$topo31.set_deferred("disabled", false)
			$topo32.set_deferred("disabled", false)
			$topo33.set_deferred("disabled", false)



	index = blockIndex
	position = pos

	base_position = position
#	position = pos
	position.x -= sway
	sway_amount = Vector2(sway, 0)
	
	print(tween)
	tween.interpolate_property(self, "position", position, base_position + sway_amount, 1.0)
	tween.start()
	building = true

func _on_Tween_tween_completed(_object, _key):

	if going_right:
		tween.interpolate_property(self, "position", position, base_position - sway_amount, 1.0)
		tween.start()
		going_right=false
	else:
		tween.interpolate_property(self, "position", position, base_position + sway_amount, 1.0)
		tween.start()
		going_right=true


func _on_Tween_tween_step(object, _key, _elapsed, _value):
	objPos = object.position




func _on_block_body_entered(body):
	if (index > 0):

		if body.is_in_group('ground'):
			destructionSound.play()
			get_parent().reset()


		elif body.is_in_group('columns') and !built:
			built = true
			get_parent().spawn_block()
