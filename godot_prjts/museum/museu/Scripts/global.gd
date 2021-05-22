extends Node


var current_scene = null
var root

var custom_variables = {}

var mode = 'talk';

var position = Vector2(0,0)

var state = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path):
		call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	
	# Instance the new scene.
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func save_game():
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_line(to_json(Global.custom_variables))
	file.close()


func delete_file_with_extension(ext):
	var dir = Directory.new()
	dir.open("user://")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.right((file.length()-ext.length())) == ext:
			dir.remove(file)
	dir.list_dir_end()


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"): #When we click esc
		goto_scene("res://Scenes/Museum.tscn")

