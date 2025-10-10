class_name TextAPI
extends Object

static func calculate_length(text : Text) -> int:
	if(text == null):
		printerr("text class does not created")
		return 0
	if(text.text == null):
		printerr("text does not created")
		return 0
	
	var length : int = text.text.length()
	
	if(length == 0):
		printerr("no text added")
	return length

static func get_jumps(text : Text) -> int:
	return how_many_string(text, "\n")

static func how_many_string(text : Text, letter : String) -> int:
	return text.content.countn(letter, 0, text.content.length()-1)
	
static func has_string(text : Text, letter : String) -> bool:
	return text.content.contains(letter)
