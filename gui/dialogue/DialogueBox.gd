extends Control

class_name DialogueBox

var dialogue_database: DialogueDatabase
var milestone_database: MilestoneDatabase
var FIRST = '1'
var current_dialogue

signal update_background

func _init():
	dialogue_database = DialogueDatabase.new()
	current_dialogue = dialogue_database.find_by_id(FIRST)
	milestone_database = MilestoneDatabase.new()
	
func _ready():
	show_current_dialogue()
	
func _input(event):
	if Input.is_action_just_pressed('dialogue_next'):
		advance_dialogue()
		
	if Input.is_action_just_pressed('dialogue_option'):
		# should only select an option if the current dialogue has any
		if current_dialogue.options.size() > 0:
			var option = OS.get_scancode_string(event.scancode)
			choose_dialogue_option(int(option))
	
func advance_dialogue():
	if current_dialogue.next != null:
		current_dialogue = dialogue_database.find_by_id(current_dialogue.next)
		show_current_dialogue()
		
func choose_dialogue_option(option):
	var result_dialogue_id = current_dialogue.options[option-1].result_dialogue
	var result_dialogue = dialogue_database.find_by_id(result_dialogue_id)
	
	current_dialogue = result_dialogue
	show_current_dialogue()
		
func show_current_dialogue():
	var dialogue_box_text = ''
	dialogue_box_text += current_dialogue.text + '\n'
	
	if current_dialogue.options != null:
		var optionCount = 1
		for option in current_dialogue.options:
			dialogue_box_text += String(optionCount) + '. ' + option.text + '\n'
			optionCount += 1
	
	$DialogueText.set_bbcode(dialogue_box_text)
	update_background()	
		
func update_background():
	emit_signal('update_background', current_dialogue.backgroundID)