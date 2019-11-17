class_name DialogueDatabase

var dialogue: Dictionary

func _init():
	load_dialogue("res://DialogTable.json")

# Loads dialogue data from .json file
func load_dialogue(file_path):
	var file = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var _dialogue = parse_json(file.get_as_text())
	file.close()
	
	self.dialogue = _dialogue

# Returns the dialogue entry with the given ID or null if it doesn't exist
func find_by_id(id):
	return dialogue.get(id)