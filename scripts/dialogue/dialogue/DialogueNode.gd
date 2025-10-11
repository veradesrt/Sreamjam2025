class_name DialogueNode
extends Control

const DIALOGUE_BASIC_SCENE : PackedScene = preload("uid://gt614lqfnysu")

#current_dialogue_process

var dp_queue : Array[DialogueProcess]

var cdp : DialogueProcess


func _enter_tree() -> void:
	DialogueGlobalEmitter.start_dialogue.connect(start_dialogue)
	DialogueGlobalEmitter.force_end_conversation.connect(end_dialogue)
	#DialogueGlobalEmitter.force_end_dialogue
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	anchors_preset = Control.PRESET_FULL_RECT

func _process(delta: float) -> void:
	if(cdp == null):
		return
	
	if(Input.is_action_just_pressed("enter")):
		if(cdp.all_text_showed and cdp.current_text.enable_skip):
			next_text()
			return
		elif(cdp.current_text.can_skip_write):
			show_complete_text()
	
	if(cdp.current_text.enable_typewrite and cdp.all_text_showed == false):
		cdp.tick_letter_count += delta
		if(cdp.tick_letter_count > cdp.current_text.typewrite_speed):
			next_letter()

func start_dialogue(dialogue : Dialogue) -> void:
	
	if(dp_queue.is_empty()):
		dp_queue.append(create_dialogue_process(dialogue))
		next_dialogue()
	else:
		dp_queue.append(create_dialogue_process(dialogue))
	
	
		#DialogueGlobalEmitter.already_running.emit()
		#dp_queue.append(create_dialogue_process(dialogue))
		#printerr("already running a dialogue, added to queue")
		#return

func end_dialogue() -> void:
	remove_ui(cdp.dialogue_box)
	cdp.next_text_timer.queue_free()
	cdp = null
	DialogueGlobalEmitter.has_ended.emit()
	dp_queue.pop_front()
	
	if(!dp_queue.is_empty()):
		next_dialogue()

func force_end_conversation() -> void:
	pass

func create_dialogue_process(dialogue : Dialogue) -> DialogueProcess:
	var dp = DialogueProcess.new()
	dp.dialogue = dialogue
	dp.dialogue_length = dp.dialogue.dialogue.size()-1
	
	match(dialogue.mode):
		Dialogue.Mode.BASIC:
			dp.dialogue_box = DIALOGUE_BASIC_SCENE.instantiate() as BasicBoxUI
		_:
			printerr("not let the default one triggers lol")
	
	return dp

func next_dialogue() -> void:
	cdp = dp_queue.front()
	instantiate_nodes(cdp)
	DialogueGlobalEmitter.has_started.emit()
	next_text()

func next_text() -> void:
	
	cdp.all_text_showed = false
	
	if(cdp.next_text_timer.timeout.is_connected(next_text)):
		cdp.next_text_timer.timeout.disconnect(next_text)

	if(!cdp.next_text_timer.is_stopped()):
		cdp.next_text_timer.stop()
	
	cdp.current_text_count+=1
	
	if(cdp.current_text_count > cdp.dialogue_length):
		end_dialogue()
		return
	
	var new_text : Text = cdp.dialogue.dialogue[cdp.current_text_count]
	cdp.current_text = new_text
	
	cdp.next_text_timer.wait_time = cdp.current_text.skip_time
	cdp.next_text_timer.timeout.connect(next_text)
	
	if(new_text.enable_typewrite):
		next_letter()
	else:
		finish_text()
	

func next_letter() -> void:
	cdp.current_letter_count += cdp.current_text.letters_per_write
	cdp.tick_letter_count -= cdp.current_text.typewrite_speed
	var content : String = cdp.current_text.content
	
	if(cdp.current_letter_count == 0):
		cdp.tick_letter_count = 0
	
	if(cdp.current_letter_count > content.length() -1):
		finish_text()
		cdp.tick_letter_count = 0
		cdp.current_letter_count = -1
		return
	
	if(content[cdp.current_letter_count] == "["):
		for i in content.length():
			cdp.current_letter_count+=1
			if(content[cdp.current_letter_count] == "]"):
				cdp.current_letter_count+=1
				break
	
	cdp.current_letter_count = clamp(cdp.current_letter_count,0,content.length())
	
	var new_content : String = content.substr(0,cdp.current_letter_count)
	cdp.dialogue_box.set_text(new_content)

func finish_text() -> void:
	show_complete_text()
	if(cdp.current_text.can_auto_skip):
		cdp.next_text_timer.start()

func show_complete_text() -> void:
	cdp.dialogue_box.set_text(cdp.current_text.content)
	cdp.all_text_showed = true

func instantiate_nodes(dp : DialogueProcess) -> void:
	add_ui(dp.dialogue_box)
	var ntt : Timer = Timer.new()
	add_child(ntt)
	cdp.next_text_timer = ntt

func add_ui(box : DialogueBoxUI) -> void:
	add_child(box)

func remove_ui(box : DialogueBoxUI) -> void:
	box.queue_free()
