extends AnimatedSprite

var mouse_in = false
var dragging = false
var mouse_to_center_set = false
var mouse_to_center
var sprite_pos
var mouse_pos

var draggable_object = preload("res://Scenes/DraggableAnimSprite.tscn")

#var pickables = preload("res://Scenes/Pick2Drag.tscn")
var object_type

var nm

var sprite_dict


func _input(_event):
	if (Input.is_action_just_pressed("left_click") && mouse_in) and Global.mode != "talk": #When clicking
		#First we set mouse_to_center as a static vector
		#for preventing the sprite to move its center to the mouse position
		mouse_pos = get_viewport().get_mouse_position()
		mouse_to_center = restaVectores(self.position, mouse_pos)
		
		
		var a = draggable_object.instance()
		#sets sprite to animation in dict corresponding to parent node
		a.object_type = object_type
		a.set_animation(object_type)
		a.set_position(Vector2(self.get_position().x+100,self.get_position().y))
		get_parent().add_child(a)
		

func _process(_delta):
	if (dragging):
		mouse_pos = get_viewport().get_mouse_position()
		#Set the position of the sprite to
		#mouse position + static mouse_to_center vector
		#set_position(sumaVectores(mouse_pos, mouse_to_center))

func _on_Area2D_mouse_entered():
	mouse_in = true
	nm = name
	#get_parent()._add_sprite(self) #Add the sprite to the sprite list

func _on_Area2D_mouse_exited():
	mouse_in = false
	#print(a.name)
	#get_parent()._remove_sprite(self)  #Remove the sprite from the sprite list


func restaVectores(v1, v2): #vector substraction
	return Vector2(v1.x - v2.x, v1.y - v2.y)
	
func sumaVectores(v1, v2): #vector sum
	return Vector2(v1.x + v2.x, v1.y + v2.y)
