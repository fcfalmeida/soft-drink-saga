extends Control

class_name DialogueBox

var dialogue_database
var FIRST = '1'
var current_dialogue

func _init():
	dialogue_database = DialogueDatabase.new()
	current_dialogue = dialogue_database.find_by_id(FIRST)
	
func _ready():
	show_current_dialogue()
	
func _on_NextButton_pressed():
	if current_dialogue.next != null:
		print(current_dialogue.next)
		current_dialogue = dialogue_database.find_by_id(current_dialogue.next)
		show_current_dialogue()
		
	if current_dialogue.next == null:
		$Panel/NextButton.hide()
	else:
		$Panel/NextButton.show()

func show_current_dialogue():
	var dialogue_box_text = ""
	dialogue_box_text += current_dialogue.text + "\n"
	
	for option in current_dialogue.options:
		dialogue_box_text += option.text + "\n"
	
	$Panel/DialogueText.set_bbcode(dialogue_box_text)
		