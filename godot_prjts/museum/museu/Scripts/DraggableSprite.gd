extends AnimatedSprite

var mouse_in = false
var dragging = false
var mouse_to_center_set = false
var mouse_to_center
var sprite_pos
var mouse_pos
var object_type

var fachada_home
var can_drag = true

func _ready():
	fachada_home = get_tree().get_nodes_in_group("fachada")[0]

func _input(_event):
	if (Input.is_action_just_pressed("left_click") && mouse_in) and Global.mode != "talk": #When clicking
		#First we set mouse_to_center as a static vector
		#for preventing the sprite to move its center to the mouse position
		mouse_pos = get_viewport().get_mouse_position()
		mouse_to_center = restaVectores(self.position, mouse_pos)
		get_parent().current_obj = self


func _process(_delta):
	if (dragging):
		mouse_pos = get_viewport().get_mouse_position()
		#Set the position of the sprite to
		#mouse position + static mouse_to_center vector
		set_position(sumaVectores(mouse_pos, mouse_to_center))

func _on_Area2D_mouse_entered():
	mouse_in = true
	fachada_home._add_sprite(self) #Add the sprite to the sprite list
	

func _on_Area2D_mouse_exited():
	mouse_in = false
	fachada_home._remove_sprite(self)  #Remove the sprite from the sprite list

func restaVectores(v1, v2): #vector substraction
	return Vector2(v1.x - v2.x, v1.y - v2.y)
	
func sumaVectores(v1, v2): #vector sum
	return Vector2(v1.x + v2.x, v1.y + v2.y)
