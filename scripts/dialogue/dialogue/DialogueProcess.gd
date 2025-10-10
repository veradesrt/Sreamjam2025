class_name DialogueProcess
extends RefCounted

var all_text_showed : bool
var dialogue : Dialogue
var dialogue_length : int
var current_text : Text
var current_text_count : int = -1
var current_letter_count : int = -1

var next_text_timer : Timer
var next_letter_timer : Timer
var dialogue_box : DialogueBoxUI
