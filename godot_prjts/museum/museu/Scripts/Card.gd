extends TextureButton

class_name Card

onready var Game = get_tree().get_root().get_node("CardsGame")
var suit
var value
var face
var back = preload("res://Assets/Sprites/cards/cardBack_red3.png")

func _ready():
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	

func _init(var s, var v):
	value = v
	suit = s
	face = load("res://Assets/Sprites/cards/card-"+ str(suit) + "-" + str(value) + ".png")
	set_normal_texture(back)
	
func _pressed():
	Game.chooseCard(self)
	
func flip():
	if get_normal_texture() == back:
		set_normal_texture(face)
	else:
		set_normal_texture(back)
		
