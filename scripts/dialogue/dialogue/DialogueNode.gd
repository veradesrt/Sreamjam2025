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
	cdp = null
	DialogueGlobalEmitter.has_ended.emit()

func next_text() -> void:
	
	if(cdp.next_text_timer.timeout.is_connected(next_text)):
		cdp.next_text_timer.timeout.disconnect(next_text)
	if(cdp.next_letter_timer.timeout.is_connected(next_letter)):
		cdp.next_letter_timer.timeout.disconnect(next_letter)
	
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
		cdp.next_text_timer.start()
		cdp.next_text_timer.timeout.connect(next_text)
		cdp.dialogue_box.set_text(new_text.content)
		

func next_letter() -> void:
	pass

func force_end_dialogue() -> void:
	pass

func add_ui(box : DialogueBoxUI) -> void:
	add_child(box)

func remove_ui(box : DialogueBoxUI) -> void:
	box.queue_free()
