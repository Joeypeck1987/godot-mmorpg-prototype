extends Node2D

@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText

var dialogue_lines: Array[String] = [
	"Easy now. The tide carried you farther than most folk dare to go.",
	"The shore ahead is Ashport, but",
	"Keep your eyes open...",
	"...",
	"The bells have started ringing again.",
	"...",
	"Dead men walk... Beasts change shape... Old roads lead where they should not...",
	"...Some hear the bells and keep walking...",
	"We call those ones Wayfarers.",
	"Now then... let us get you ashore."
]

var dialogue_index: int = 0

func _ready():
	dialogue_box.visible = true
	dialogue_text.text = dialogue_lines[dialogue_index]

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		advance_dialogue()

func advance_dialogue():
	dialogue_index += 1

	if dialogue_index >= dialogue_lines.size():
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	else:
		dialogue_text.text = dialogue_lines[dialogue_index]
