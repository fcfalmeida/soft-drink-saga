extends Control

class_name DialogueBox

var dialogue_database: DialogueDatabase
var milestone_database: MilestoneDatabase
var FIRST = '1'
var current_dialogue

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
		if check_required_milestone(current_dialogue):
			current_dialogue = dialogue_database.find_by_id(current_dialogue.next)
			complete_milestone(current_dialogue)
			show_current_dialogue()
		else:
			show_milestone_required(current_dialogue)
	if current_dialogue.next == null:
		$Panel/NextButton.hide()
	else:
		$Panel/NextButton.show()
		
func choose_dialogue_option(option):
	var result_dialogue_id = current_dialogue.options[option-1].result_dialogue
	var result_dialogue = dialogue_database.find_by_id(result_dialogue_id)
	
	if check_required_milestone(result_dialogue):
		current_dialogue = result_dialogue
		complete_milestone(current_dialogue)
		show_current_dialogue()
	else:
		show_milestone_required(result_dialogue)
		
func show_current_dialogue():
	var dialogue_box_text = ''
	dialogue_box_text += current_dialogue.text + '\n'
	
	for option in current_dialogue.options:
		dialogue_box_text += option.text + '\n'
	
	$Panel/DialogueText.set_bbcode(dialogue_box_text)
	
func show_milestone_required(dialogue):
	var milestone_id = dialogue.required_milestone
	var milestone = milestone_database.find_by_id(milestone_id)
	
	var non_completion_dialogue = dialogue_database.find_by_id(milestone.non_completion_dialogue)
	current_dialogue = non_completion_dialogue
	
	show_current_dialogue()
	
func check_required_milestone(dialogue) -> bool:
	var milestone_id = dialogue.required_milestone
	
	if  milestone_id != null:
		return milestone_database.is_milestone_completed(milestone_id)
	
	return true
	
func complete_milestone(dialogue):
	if dialogue.complete_milestone != null:
		milestone_database.complete_milestone(dialogue.complete_milestone)