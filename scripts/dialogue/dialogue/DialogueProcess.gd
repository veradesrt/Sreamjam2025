class_name DialogueProcess
extends RefCounted

var all_text_showed : bool
var dialogue : Dialogue
var dialogue_length : int

#for text
var current_text : Text
var current_text_count : int = -1

#for typewrite
var current_letter_count : int = -1
var tick_letter_count : float = 0

#nodes
var next_text_timer : Timer
var dialogue_box : DialogueBoxUI
