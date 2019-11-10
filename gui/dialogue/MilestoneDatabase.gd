class_name MilestoneDatabase

var milestones: Dictionary

func _init():
	load_milestones("res://milestones.json")
	
# Loads milestone data from .json file
func load_milestones(file_path):
	var file = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var _milestones = parse_json(file.get_as_text())
	file.close()
	
	self.milestones = _milestones
	
# Marks the milestone with the given id as completed
func complete_milestone(milestone_id):
	milestones.milestone_id.completed = true
	
# Checks if the milestone with the given id has already been completed
func is_milestone_completed(milestone_id):
	var milestone = milestones.get(milestone_id)
	return milestone.completed
	
# Returns the milestone with the given ID or null if it doesn't exist
func find_by_id(id):
	return milestones.get(id)