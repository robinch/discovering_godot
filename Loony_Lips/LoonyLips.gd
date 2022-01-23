extends Control

var player_words = []
var current_story = {}
var intro_done = false

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText
onready var ButtonText = $VBoxContainer/HBoxContainer/ButtonText

func _ready():
	set_current_story()
	PlayerText.hide()
	ButtonText.text = "Start!"
	DisplayText.text =  "Welcome to this Shitty game. You will be prompted to add words, just do it... Press OK to start playing... yay..."

func set_current_story():
	randomize()
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story


func _on_PlayerText_text_entered(_new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()


func add_to_player_words():
	if not intro_done:
		PlayerText.show()
		intro_done = true
		prompt_player()
	else:
		player_words.append(PlayerText.text)
		PlayerText.clear()
		check_player_words_length()


func is_story_done():
	return player_words.size() == current_story.prompts.size()


func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
	

func tell_story():
	DisplayText.text = current_story.story % player_words
	
	
func prompt_player():
	DisplayText.text = "May I have " + current_story.prompts[player_words.size()] + "?"
	ButtonText.text = "Ok"
	PlayerText.grab_focus()


func end_game():
	PlayerText.queue_free()
	ButtonText.text = "Again!"
	tell_story()
	
	
	
	
	
	
	
	
	
	



