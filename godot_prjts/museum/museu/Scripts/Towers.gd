extends StaticBody2D

var plant_block = load("res://Scenes/block.tscn")
var instance
var sway_amount = 300
var X_AXIS = 0
var Y_AXIS = 688
var blockIndex = 1
var score = 0
var height = 0
var cameraPos = Vector2()
var atualPosition = Vector2()
onready var camera = get_node("Camera2D")
onready var scoreLabel = get_node("Camera2D/score")
onready var secondsLabel = get_node("Camera2D/seconds")

var flipTimer = Timer.new()
var nextLvlSecTimer = Timer.new()


const GRAVITY = 10.0
const SPAWN_DISTANCE = 500

var limit = true
var limitMax = 4

var level = 1
var secondsTimer = Timer.new()

var seconds = 0

func _ready():
	Global.mode = 'move'
	Engine.iterations_per_second = 180
	X_AXIS = get_viewport().get_visible_rect().size.x/2
	seconds=0
	secondsLabel.text = str(seconds)
	setupTimer()
	setBase()

func _ready2():
	Global.mode = 'move'
	Engine.iterations_per_second = 180
	X_AXIS = get_viewport().get_visible_rect().size.x/2
#	seconds=0
	secondsLabel.text = str(seconds)
#	setupTimer()
	setBase()

func setupTimer():
	secondsTimer.connect("timeout", self, "countSeconds")
	add_child(secondsTimer)
	secondsTimer.start()
	
	flipTimer.connect("timeout", self, "turnOffScore")
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	nextLvlSecTimer.connect("timeout", self, "nextLvl")
	nextLvlSecTimer.set_one_shot(true)
	add_child(nextLvlSecTimer)

func countSeconds():
	if Global.mode != 'talk':
		seconds +=1
		secondsLabel.text = str(seconds)

func setBase():
	instance = plant_block.instance()
	add_child(instance)
	
	var sprite = 'base2'
	match level:
			1:
				sprite = "base2"				
			2:
				sprite = "base3"
			3:
				sprite = "base1"
			4:
				sprite = "base3"
				
	colsLevel()
	instance.base(sprite)
	atualPosition = Vector2(X_AXIS, Y_AXIS)
	cameraPos = Vector2(X_AXIS, get_viewport().get_visible_rect().size.y/2)
	instance.global_transform.origin = atualPosition
	instance.gravity_scale = GRAVITY
	height = Y_AXIS
	spawn_block()
	

func _process(_delta):
	camera.position = lerp(camera.position, cameraPos, 0.05)

func colsLevel():
	
	match level:
			1:
				$Camera2D/coluna1.visible = false;
				$Camera2D/coluna2.visible = false;
				$Camera2D/coluna3.visible = false;
			2:
				$Camera2D/coluna1.visible = true;
				$Camera2D/coluna2.visible = false;
				$Camera2D/coluna3.visible = false;
			3:
				$Camera2D/coluna1.visible = true;
				$Camera2D/coluna2.visible = true;
				$Camera2D/coluna3.visible = false;
			4:
				$Camera2D/coluna1.visible = true;
				$Camera2D/coluna2.visible = true;
				$Camera2D/coluna3.visible = true;

func showScore():
	$Camera2D/score.visible=true
	flipTimer.start(1)
	
	
func turnOffScore():
	$Camera2D/score.visible=false
	

func spawn_block():
	if(limit and blockIndex < limitMax) or (!limit):
		instance = plant_block.instance()
		add_child(instance)
		if blockIndex > 0:
			height -= 170
			cameraPos = Vector2(X_AXIS, height)
			
			
		atualPosition = Vector2(X_AXIS, height - SPAWN_DISTANCE)
		
		scoreLabel.text = str(score)
		blockIndex = blockIndex +1
		score = score + 1
		showScore()
		
		var sprite = "centro2"
		
		match level:
			1:
				limitMax = 5
				sprite = "centro2"
				if(limit and blockIndex == limitMax):
					sprite = "topo2"
			2:
				limitMax = 7
				sprite = "centro3"
				if(limit and blockIndex == limitMax):
					sprite = "topo3"
			3:
				limitMax = 9
				sprite = "centro1"
				if(limit and blockIndex == limitMax):
					sprite = "topo1"
			4:
				limit = false
				limitMax = 10
				sprite = "centro3"
				if(limit and blockIndex == limitMax):
					sprite = "topo3"
					
		instance.initialize(atualPosition, sway_amount, blockIndex, sprite)
		
	else:
		explain()
	

func explain():
	scoreLabel.text = "Score: " + str(blockIndex)
	setDialog()
	
func setDialog():
	if Global.mode != 'talk':
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = "res://addons/dialogs/tower" + str(level) + ".json"
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position(Vector2(cameraPos))
		add_child(dialog)
	
func next():
	var columns = get_tree().get_nodes_in_group("columns")
	for col in columns:
		col.queue_free()
	nextLvlSecTimer.start(0.5)
	
func endGame():
	Global.mode = 'move';
	if "towers_score" in Global.custom_variables:		
		if Global.custom_variables.towers_score < score:
			Global.custom_variables['towers_score'] = score
	else:
		Global.custom_variables['towers_score'] = score
		Global.custom_variables['status_towers'] = true
	
	_on_TextureButton_pressed()

func nextLvl():
	Global.mode = 'move'
	level+=1
	colsLevel()
	blockIndex = 0
	setBase()

func reset():	
	if level == 4:
		setDialog()
	else:
		if Global.mode != 'talk':
			for child in get_children():
				if child.is_in_group('columns'):
					child.queue_free()
					
			blockIndex = 0
			match level:
				1:
					score = 0
				2:
					score = 5
				3:
					score = 13
	#		level = 1
			colsLevel()
			_ready2()
	

func _on_TextureButton_pressed():
	Global.goto_scene("res://Scenes/Menu_Jogos.tscn")
