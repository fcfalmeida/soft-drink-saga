class_name Milestone

# Milestone description
var description: String
# Text displayed when trying to move to a dialogue which requires
# this milestone while it hasn't been completed yet
var no_completion_text: String
# Text displayed when this milestone is completed
var completion_text: String

func _init(description: String, no_completion_text: String, completion_text: String):
	self.description = description
	self.no_completion_text = no_completion_text
	self.completion_text = completion_text