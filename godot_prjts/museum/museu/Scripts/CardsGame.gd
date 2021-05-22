extends Control

var deck =  Array()
var cardBack = preload("res://Assets/Sprites/cards/cardBack_red3.png")
var card1
var card2
var matchTimer= Timer.new()
var flipTimer = Timer.new()
var secondsTimer = Timer.new()
var score = 0
var seconds= 0
var moves = 0
var scoreLabel
var secondsLabel
var movesLabel
onready var successSound = get_node("successSound")
#onready var dropSound = get_node("success")
var X_AXIS = 0
var Y_AXIS = 688

func _ready():
	X_AXIS = get_viewport().get_visible_rect().size.x/2
	Y_AXIS = get_viewport().get_visible_rect().size.y/2
	
	fillDeck()
	dealDeck()
	setup()
	setupTimers()


func setup():
	scoreLabel = self.get_node('Panel/Sections/SectionScore/score')
	secondsLabel = self.get_node('Panel/Sections/SectionTimer/seconds')
	movesLabel = self.get_node('Panel/Sections/SectionMoves/moves')

	scoreLabel.text= str(score)
	secondsLabel.text= str(seconds)
	movesLabel.text= str(moves)
	
	

func setupTimers():
	flipTimer.connect("timeout", self, "turnOverCards")
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect("timeout", self, "matchCardsAndScore")
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	
	secondsTimer.connect("timeout", self, "countSeconds")
	add_child(secondsTimer)
	secondsTimer.start()
	
	
func countSeconds():
	if Global.mode != 'talk':
		seconds+=1
		secondsLabel.text= str(seconds)
	
	
	
func fillDeck():
	var s = 1
	var v = 1
	while s < 3:
		v=1
		while v<10:
			deck.append(Card.new(s, v))
			v = v + 1
		s+=1
	
	
func dealDeck():
	randomize()
	deck.shuffle()
	var c = 0
	while c < deck.size():
		self.get_node('grid').add_child(deck[c])
		c+=1


func chooseCard(var c):
	if card1 == null:
		card1 = c
		card1.flip()
		card1.set_disabled(true)
	elif card2 ==null:
		card2 = c
		card2.flip()
		card2.set_disabled(true)
		moves+=1
		movesLabel.text = str(moves)
		checkCards()
		
func checkCards():
	if card1.value == card2.value:
		matchTimer.start(1)
	else:
		flipTimer.start(1)
		
		
func turnOverCards():
	card1.flip()
	card2.flip()
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null
	
func matchCardsAndScore():
	successSound.play()
	score += 1
	scoreLabel.text= str(score)
	setDialog()

	
	
func setDialog():
	var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.extenal_file = "res://addons/dialogs/carta" + str(card1.value) + ".json"
	Global.mode = 'talk';
	var Y_AXIS = get_viewport().get_visible_rect().size.y/2
	dialog.set_position(Vector2(0,-500))
	add_child(dialog)
	

func next():
	card1.set_modulate(Color(0.6, 0.6, 0.6, 0.5))
	card2.set_modulate(Color(0.6, 0.6, 0.6, 0.5))
	card1 = null
	card2 = null
	Global.mode = 'move';	
	if score == 9:
		var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
		dialog.extenal_file = "res://addons/dialogs/cartaFim.json"
		Global.mode = 'talk';
		dialog.set_position(Vector2(0,-500))
		add_child(dialog)


func endGame():
	Global.mode = 'move';
	if "cards_time" in Global.custom_variables:		
		if Global.custom_variables.cards_time > seconds:
			Global.custom_variables['cards_time'] = seconds
	else:
		Global.custom_variables['cards_time'] = seconds
		Global.custom_variables['status_cards'] = true
	_on_TextureButton_pressed()

func _on_TextureButton_pressed():
	Global.goto_scene("res://Scenes/Menu_Jogos.tscn")
