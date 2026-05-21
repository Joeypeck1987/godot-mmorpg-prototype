extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var collision_tilemap: TileMapLayer = $CollisionTileMap
@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText

var dialogue_lines: Array[String] = []
var dialogue_index: int = 0
var dialogue_active: bool = false

func _ready():
	dialogue_box.visible = false

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if dialogue_active:
			advance_dialogue()
		else:
			try_inspect_tree()

func try_inspect_tree():
	var facing_direction = player.last_direction
	var check_offset = Vector2.ZERO

	if facing_direction == "down":
		check_offset = Vector2(0, 32)
	elif facing_direction == "up":
		check_offset = Vector2(0, -32)
	elif facing_direction == "left":
		check_offset = Vector2(-32, 0)
	elif facing_direction == "right":
		check_offset = Vector2(32, 0)

	var check_position = player.global_position + check_offset
	var map_position = collision_tilemap.local_to_map(collision_tilemap.to_local(check_position))
	var tile_data = collision_tilemap.get_cell_tile_data(map_position)

	if tile_data != null:
		start_dialogue([
			"You inspect the old tree...",
			"The forest is unusually quiet."
		])

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
