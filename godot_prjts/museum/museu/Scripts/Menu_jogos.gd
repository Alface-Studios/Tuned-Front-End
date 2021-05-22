extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Music.is_playing():
		Music.play_music(Music.music_position)
	Global.save_game()
	$bg/nuvens/AnimationPlayer.play("nuvens")
	$bg/sol/AnimationPlayer.play("sun")
	Global.mode = "move"
	$bg/aguas/AnimationPlayer.play("aguas")
	$bg/peixes/AnimationPlayer.play("peek")
	$bg/peixes2/AnimationPlayer.play("peek")
	$bg/peixes3/AnimationPlayer.play("peek")
	$bg/peixes4/AnimationPlayer.play("peek")
	randomize()
	var tween = get_node("Tween")
	tween.interpolate_property($bg/barcos/barco1, "position", 
	Vector2(rand_range(6000,6500),855), Vector2(-300,855), 240,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	if Global.state == "from_game":
		$Sileno.position = Global.position
		$Camera2D.global_position.x = Global.position.x
	else:
		var json_path = "res://addons/dialogs/sileno_intro.json"
		if Global.state == "fresh":
			json_path = "res://addons/dialogs/sileno_intro.json"
		elif Global.state == "load":
			json_path = "res://addons/dialogs/sileno_intro2.json"
		print(json_path)
		$Sileno.balc_final_x = $bg/balcs/balcfinal.global_position.x + 350
		$Sileno/AnimationPlayer.play("walk_in")
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = json_path
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$sileno.play()
		

	
	
func _process(_delta):
	if $Sileno.global_position.x > get_viewport().get_visible_rect().size.x/2 and $Sileno.global_position.x < $bg/balcs/balcfinal.global_position.x:
		$Camera2D.global_position.x = lerp($Camera2D.global_position.x, $Sileno.global_position.x, 0.05)

func _on_cartas_pressed():
	if Global.mode != 'talk':
		var json_path = "res://addons/dialogs/caliope_intro.json"
		Global.state = "from_game"
		if "status_cards" in Global.custom_variables and Global.custom_variables.status_cards == true:
			json_path = "res://addons/dialogs/caliope_intro2.json"
		else:
			json_path = "res://addons/dialogs/caliope_intro.json"
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = json_path
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$musa1.play()



func _on_fachada_pressed():
	if Global.mode != 'talk':
		var json_path = "res://addons/dialogs/euterpe_intro.json"
		Global.state = "from_game"
		if "status_fachada" in Global.custom_variables and Global.custom_variables.status_fachada == true:
			json_path = "res://addons/dialogs/euterpe_intro2.json"
		else:
			json_path = "res://addons/dialogs/euterpe_intro.json"
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = json_path
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$musa2.play()


func _on_torre_pressed():	
	if Global.mode != 'talk':
		var json_path = "res://addons/dialogs/urania_intro.json"
		Global.state = "from_game"
		if "status_towers" in Global.custom_variables and Global.custom_variables.status_towers == true:
			json_path = "res://addons/dialogs/urania_intro2.json"
		else:
			json_path = "res://addons/dialogs/urania_intro.json"
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = json_path
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$musa3.play()


func _on_bancada_pressed():
	if Global.mode != 'talk':
		var json_path = "res://addons/dialogs/polimnia_intro.json"
		Global.state = "from_game"
		if "status_bancada" in Global.custom_variables and Global.custom_variables.status_bancada == true:
			json_path = "res://addons/dialogs/polimnia_intro3.json"			
		elif !("status_bancada" in Global.custom_variables and Global.custom_variables.status_bancada == true) and "status_cards" in Global.custom_variables and Global.custom_variables.status_cards == true and "status_towers" in Global.custom_variables and Global.custom_variables.status_fachada == true and "status_fachada" in Global.custom_variables and Global.custom_variables.status_fachada == true:
			json_path = "res://addons/dialogs/polimnia_intro2.json"
		else:
			json_path = "res://addons/dialogs/polimnia_intro.json"
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = json_path
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$musa4.play()
	
func end_talk():
	Global.mode = 'move';
	
func _on_peixes_pressed():
	if Global.mode != 'talk':
		var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
		dialog.get_node('Dialog').extenal_file = "res://addons/dialogs/peixes.json"	
		Global.mode = 'talk';
		dialog.get_node('Dialog').set_position($Camera2D.position)
		add_child(dialog)
		$peixes.play()


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		if Global.mode != 'talk':
			var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
			dialog.get_node('Dialog').extenal_file = "res://addons/dialogs/barcos.json"	
			Global.mode = 'talk';
			dialog.get_node('Dialog').set_position($Camera2D.position)
			add_child(dialog)
			$barco.play()


func _on_melpomene_pressed():
		if Global.mode != 'talk':
			var dialog = load("res://addons/dialogs/Dialog_node.tscn").instance()
			
			var dialogo = []			
			
			if "status_melpomene" in Global.custom_variables and Global.custom_variables.status_melpomene == false:
				dialogo.push_back({"name": "Melpomene","text": "Salutações [player_name]! Sou a Melpomene, a musa da tragédia."})
				dialogo.push_back({"name": "Melpomene","text": "Sileno aposto que ainda não está nada pronto para a festa de hoje!"})
				dialogo.push_back({"name": "Melpomene","text":  "No Teatro Romano em Lisboa podes ver um fragmento de uma estátua minha, estás covidado!"})
				dialogo.push_back({"name": "Melpomene","text":  "Sempre que quiseres consultar os teus resultados fala comigo."})
				dialogo.push_back({"action": "end_talk"})
			else: 
				dialogo.push_back({"name": "Melpomene","text": "Como estás [player_name]?"})
				
				if "status_cards" in Global.custom_variables and Global.custom_variables.status_cards == true:
					dialogo.push_back({"name": "Melpomene","text": "Tens de falar com a Calíope para completares o seu desafio."})
				else:
					dialogo.push_back({"name": "Melpomene","text": "Completaste o desafio da Calíope em [cards_time] segundos."})
					
				if "status_towers" in Global.custom_variables and Global.custom_variables.status_towers == true:
					dialogo.push_back({"name": "Melpomene","text": "Pergunta à musa Urania pela sua tarefa."})
				else:
					dialogo.push_back({"name": "Melpomene","text": "Conseguiste empilhar [] blocos, parabéns!"})
				
				if "status_fachada" in Global.custom_variables and Global.custom_variables.status_fachada == true:
					dialogo.push_back({"name": "Melpomene","text": "Guia o Sileno até à musa Euterpe, ela necessita da tua ajuda."})
				else:
					dialogo.push_back({"name": "Melpomene","text": "Completaste a fachada cénica mesmo a tempo, [fachada_time] segundos."})	

				if "status_bancada" in Global.custom_variables and Global.custom_variables.status_bancada == true:
					dialogo.push_back({"name": "Melpomene","text": "Assim que terminares todas as tarefas, dirige-te à musa Polimnia para a tarefa final."})
				else:
					dialogo.push_back({"name": "Melpomene","text": "Graças a ti conseguimos ter todos os preparativos a tempo, obrigada [player_name]."})	

				dialogo.push_back({"name": "Melpomene","text":  "Sempre que quiseres consultar os teus resultados fala comigo."})
				dialogo.push_back({"action": "end_talk"})
				
			dialog.get_node('Dialog').dialog_script = dialogo
			Global.mode = 'talk';
			Global.custom_variables['status_melpomene'] = true
			dialog.get_node('Dialog').set_position($Camera2D.position)
			add_child(dialog)
