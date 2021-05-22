# Made with love by JuanCarlos "Juanky" Aguilera
# Github Repo: https://github.com/JCAguilera/godot3-drag-and-drop

extends Node

var sprites = []
var top_sprite = null

onready var status = $Status
onready var spriteList = $SpriteList

var pickable_object = preload("res://Scenes/PickableAnimSprite.tscn")

var sprite_dict = {"Pickable1": "escravo", "Pickable2": "cidadao", "Pickable3": "patricio", "Pickable4": "domina", "Pickable5": "sacerdote", "Pickable6": "soldado"}
var docks = []
var current_obj
onready var successSound = get_node("successSound")
onready var goal = get_tree().get_nodes_in_group("docks").size()
var current = 0

func _ready():
	Global.mode = 'move';
	var count = 1
	for i in sprite_dict:
		var a = pickable_object.instance()
		#sets sprite to animation in dict corresponding to defined veriable in the top
		var anim = sprite_dict.get(i)
		a.object_type = anim
		a.set_animation(anim)
		a.set_position(Vector2(200*count,200))
#		if anim == "collumn1":
#			a.scale = Vector2(0.15,0.15)
#		else:
#			a.scale = Vector2(0.3,0.3)
		count += 1
		self.call_deferred("add_child", a)

func _input(_event):
	if Input.is_action_just_pressed("left_click") and Global.mode != "talk": #When we click
		top_sprite = _top_sprite() #Get the sprite on top (largest z_index)
		if top_sprite and top_sprite.can_drag: #If there's a sprite
			top_sprite.dragging = true #We set dragging to true
			
			
	if Input.is_action_just_released("left_click") and Global.mode != "talk": #When we release
		if top_sprite:
			top_sprite.dragging = false #Set dragging to false
			top_sprite = null #Top sprite to null
	_print_status()

class SpritesSorter: #Custom sorter
	static func z_index(a, b): #Sort by z_index
		if a.z_index > b.z_index:
			return true
		return false

func _add_sprite(sprt): #Add sprite to list
	if not sprites.find(sprt) == -1: #If sprite exists
		return #Do nothing
	sprites.append(sprt) #Add sprite to list

func _remove_sprite(sprt): #Remove sprite from list
	var idx = sprites.find(sprt) #find the index
	sprites.remove(idx) #remove

func _top_sprite(): #Get the top sprite
	if len(sprites) == 0: #If the list is empty
		return null
	sprites.sort_custom(SpritesSorter, "z_index") #Sort by z_index
	return sprites[0] #Return top sprite

#Print status
func _print_status():
	var aux_sprt = []
	var aux_sprt_can_drag = []
	for i in sprites:
		aux_sprt.append(i.z_index)
	for i in sprites:
		aux_sprt_can_drag.append(i.dragging)
	if not top_sprite == null:
		status.text = "Top: " + str(top_sprite.z_index) + " - Dragging: " + str(top_sprite.dragging)
		spriteList.text = "Sprites: " + str(aux_sprt) + " - Can drag: " + str(aux_sprt_can_drag)
	else:
		status.text = "Top: null - Dragging: False"
		spriteList.text = "Sprites: " + str(aux_sprt) + " - Can drag: " + str(aux_sprt_can_drag)



func _on_Dockable_dock(animation, node, position):
	if current_obj != null and current_obj.animation == animation:
		successSound.play()
		current_obj.position = position
		current_obj.can_drag = false
		node.queue_free()
		if docks.has(current_obj.animation) == false:
			docks.append(current_obj.animation)
			print(docks)
			setDialog(current_obj.animation)
		else: 
			end_level()

func setDialog(obj):
	var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.extenal_file = "res://addons/dialogs/bancada_" + obj + ".json"
	#dialog.extenal_file = "res://addons/dialogs/tower1.json"
	Global.mode = 'talk';
	dialog.set_position(Vector2(960,540))
	add_child(dialog)

func end_level():
	Global.mode = 'move';
	current += 1 
	if current == goal:
		var finalissimo = "final"
		setDialog(finalissimo)
	print(current, " ",goal)

func endGame():
	Global.mode = 'move';
	Global.custom_variables['status_fachada'] = true
	_on_TextureButton_pressed()



func _on_TextureButton_pressed():
	Global.goto_scene("res://Scenes/Menu_Jogos.tscn")
