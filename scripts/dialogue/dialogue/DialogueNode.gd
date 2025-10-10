class_name DialogueNode
extends Control

const DIALOGUE_BASIC_SCENE : PackedScene = preload("uid://gt614lqfnysu")

#current_dialogue_process
var cdp : DialogueProcess


func _enter_tree() -> void:
	DialogueGlobalEmitter.start_dialogue.connect(start_dialogue)
	DialogueGlobalEmitter.force_end_dialogue.connect(force_end_dialogue)
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	anchors_preset = Control.PRESET_FULL_RECT

func _process(delta: float) -> void:
	if(cdp == null):
		return
	
	if(Input.is_action_just_pressed("enter")):
		if(cdp.all_text_showed and cdp.current_text.enable_skip):
			next_text()
			return
		if(cdp.current_text.can_skip_write):
			show_complete_text()

func start_dialogue(dialogue : Dialogue) -> void:
	if(cdp != null):
		DialogueGlobalEmitter.already_running.emit()
		printerr("already running a dialogue")
	
	cdp = DialogueProcess.new()
	cdp.dialogue = dialogue
	
	match(dialogue.mode):
		Dialogue.Mode.BASIC:
			cdp.dialogue_box = DIALOGUE_BASIC_SCENE.instantiate() as BasicBoxUI
		_:
			printerr("not let the default one triggers lol")
	
	add_ui(cdp.dialogue_box)
	cdp.dialogue_length = cdp.dialogue.dialogue.size()-1
	
	var ntt : Timer = Timer.new()
	var nlt : Timer = Timer.new()
	
	add_child(ntt)
	add_child(nlt)
	cdp.next_text_timer = ntt
	cdp.next_letter_timer = nlt
	
	DialogueGlobalEmitter.has_started.emit()
	next_text()

func end_dialogue() -> void:
	remove_ui(cdp.dialogue_box)
	cdp.next_letter_timer.queue_free()
	cdp.next_text_timer.queue_free()
	cdp = null
	DialogueGlobalEmitter.has_ended.emit()

func next_text() -> void:
	
	if(cdp.next_text_timer.timeout.is_connected(next_text)):
		cdp.next_text_timer.timeout.disconnect(next_text)
	if(cdp.next_letter_timer.timeout.is_connected(next_letter)):
		cdp.next_letter_timer.timeout.disconnect(next_letter)
	
	if(!cdp.next_letter_timer.is_stopped()):
		cdp.next_letter_timer.stop()
	if(!cdp.next_text_timer.is_stopped()):
		cdp.next_text_timer.stop()
	
	cdp.current_text_count+=1
	
	if(cdp.current_text_count > cdp.dialogue_length):
		end_dialogue()
		return
	
	var new_text : Text = cdp.dialogue.dialogue[cdp.current_text_count]
	cdp.current_text = new_text
	
	if(new_text.enable_typewrite):
		cdp.next_letter_timer.timeout.connect(next_letter)
		pass
	else:
		show_complete_text()
	
	if(cdp.current_text.can_auto_skip):
		cdp.next_text_timer.wait_time = new_text.skip_time
		cdp.next_text_timer.timeout.connect(next_text)
		cdp.next_text_timer.start()
	

func next_letter() -> void:
	pass

func show_complete_text() -> void:
	cdp.dialogue_box.set_text(cdp.current_text.content)
	cdp.all_text_showed = true

func force_end_dialogue() -> void:
	pass

func add_ui(box : DialogueBoxUI) -> void:
	add_child(box)

func remove_ui(box : DialogueBoxUI) -> void:
	box.queue_free()
