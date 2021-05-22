extends Node2D

#var Towers = preload("res://Scenes/Towers.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var file = File.new()
var device_ID = Array([0,0])

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello world")
	if !Music.is_playing():
		Music.play_music(Music.music_position)
	$Title/AnimationPlayer.play("move")
	#$AnimationPlayer.play("sun")
	if !file.file_exists("user://deviceID.dat"):
		gen_ID()
	else:
		file.open_compressed("user://deviceID.dat",File.READ)
		device_ID[0] = file.get_32()
		device_ID[1] = file.get_32()
		file.close()
	load_game()


func _on_Button_Play_pressed():
	Music.play_button()
	$AnimationPlayer.play("fade")


func _input(_event):
	if Input.is_action_just_pressed("ui_left"):
		Global.save_game()
	elif Input.is_action_just_pressed("ui_right"):
		Global.load_game()

func _on_Button_About_pressed():
	Music.play_button()
	Global.goto_scene("res://Scenes/About.tscn")


func _on_Button_Settings_pressed():
	Music.play_button()
	Global.goto_scene("res://Scenes/Settings.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		Global.goto_scene("res://Scenes/Menu_Jogos.tscn")


func gen_ID():
	Global.state = "fresh"
	file.open_compressed("user://deviceID.dat",File.WRITE)
	device_ID = Array([OS.get_unix_time(),randi()])
	file.store_32(device_ID[0])
	file.store_32(device_ID[1])
	file.close()



func load_game():
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	var loaded = JSON.parse(content)
	print(loaded.error)
	if loaded.error == OK:
		Global.custom_variables = loaded.result
		Global.state = "load"
	print(loaded.result)
