extends Node2D

@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText
@onready var player: CharacterBody2D = $Player
@onready var monk_npc: Node2D = $MonkNPC
@onready var monk_sprite: AnimatedSprite2D = $MonkNPC/AnimatedSprite2D

var near_monk: bool = false
var near_bookshelf: bool = false
var near_stairs: bool = false
var dialogue_lines: Array[String] = []
var dialogue_index: int = 0
var dialogue_active: bool = false

func _ready():
	dialogue_box.visible = false

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if dialogue_active:
			advance_dialogue()
		elif near_monk:
			turn_monk_to_face_player()
			start_dialogue([
				"\"Do not mistake arrival for beginning.\"",
				"\"The Wheel turned toward you long before the boat touched shore.\""
			])
		elif near_bookshelf:
			start_dialogue([
				"You scan the old shelf...",
				"A little brittle book titled: \"Verses of the Return Bell.\"",
				"\"The Wheel does not hurry.\"",
				"\"Only the frightened soul calls stillness peace.\"",
				"Another line has been underlined:",
				"\"No pilgrim reaches the Axis unchanged.\""
			])
		elif near_stairs:
			start_dialogue([
				"You look up the narrow stairs...",
				"The upper floor is silent."
			])

#Monk movement
func turn_monk_to_face_player():
	var direction = player.global_position - monk_npc.global_position

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			monk_sprite.play("idle_right")
		else:
			monk_sprite.play("idle_left")
	else:
		if direction.y > 0:
			monk_sprite.play("idle_down")
		else:
			monk_sprite.play("idle_up")

func start_dialogue(lines: Array[String]):
	dialogue_lines = lines
	dialogue_index = 0
	dialogue_active = true
	dialogue_box.visible = true
	dialogue_text.text = dialogue_lines[dialogue_index]

func advance_dialogue():
	dialogue_index += 1

	if dialogue_index >= dialogue_lines.size():
		end_dialogue()
	else:
		dialogue_text.text = dialogue_lines[dialogue_index]

func end_dialogue():
	dialogue_active = false
	dialogue_box.visible = false
	dialogue_lines = []
	dialogue_index = 0

#bookshelf interaction functions
func _on_bookshelf_inspect_area_body_entered(body):
	if body.name == "Player":
		near_bookshelf = true

func _on_bookshelf_inspect_area_body_exited(body):
	if body.name == "Player":
		near_bookshelf = false
		end_dialogue()

func _on_exit_area_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

#Stair signal functions
func _on_stairs_inspect_area_body_entered(body):
	if body.name == "Player":
		near_stairs = true

func _on_stairs_inspect_area_body_exited(body):
	if body.name == "Player":
		near_stairs = false
		end_dialogue()
		
#monk signal functions
func _on_monk_talk_area_body_entered(body):
	if body.name == "Player":
		near_monk = true

func _on_monk_talk_area_body_exited(body):
	if body.name == "Player":
		near_monk = false
		end_dialogue()
