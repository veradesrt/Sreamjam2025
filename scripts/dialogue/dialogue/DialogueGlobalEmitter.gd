extends Node

signal start_dialogue(dialogue : Dialogue)
signal force_end_dialogue
signal force_end_conversation
signal already_running

signal has_started(dialogue : Dialogue)
signal has_ended(dialogue : Dialogue)
signal next_text(text : Text)
