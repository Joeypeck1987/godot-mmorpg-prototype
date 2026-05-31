extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var collision_tilemap: TileMapLayer = $CollisionTileMap
@onready var grave_tilemap: TileMapLayer = $GraveTileMap
@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText
@onready var fade_overlay: ColorRect = $FadeLayer/FadeOverlay

var dialogue_lines: Array[String] = []
var dialogue_index: int = 0
var dialogue_active: bool = false

func _ready():
	dialogue_box.visible = false
	MusicManager.play_music("res://Audio/ashport.ogg", -8.0)
	
	fade_overlay.position = Vector2.ZERO
	fade_overlay.size = get_viewport_rect().size
	fade_overlay.color = Color.BLACK
	fade_overlay.modulate.a = 1.0

	var tween := create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0.0, 1.5)

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if dialogue_active:
			advance_dialogue()
		else:
			try_inspect_object()

func try_inspect_object():
	var facing_direction = player.last_direction

	var grave_offset = Vector2.ZERO
	var tree_offset = Vector2.ZERO

	if facing_direction == "down":
		grave_offset = Vector2(0, 16)
		tree_offset = Vector2(0, 32)
	elif facing_direction == "up":
		grave_offset = Vector2(0, -16)
		tree_offset = Vector2(0, -32)
	elif facing_direction == "left":
		grave_offset = Vector2(-16, 0)
		tree_offset = Vector2(-32, 0)
	elif facing_direction == "right":
		grave_offset = Vector2(16, 0)
		tree_offset = Vector2(32, 0)

	# Check graves first
	var grave_check_position = player.global_position + grave_offset
	var grave_map_position = grave_tilemap.local_to_map(grave_tilemap.to_local(grave_check_position))
	var grave_tile_data = grave_tilemap.get_cell_tile_data(grave_map_position)

	if grave_tile_data != null:
		start_dialogue([
			"You stand before the old grave...",
			"The name has been worn away by time."
		])
		return

	# Check trees second
	var tree_check_position = player.global_position + tree_offset
	var tree_map_position = collision_tilemap.local_to_map(collision_tilemap.to_local(tree_check_position))
	var tree_tile_data = collision_tilemap.get_cell_tile_data(tree_map_position)

	if tree_tile_data != null:
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

#door enter and exit functions
func _on_door_area_body_entered(body):
	if body == player:
		get_tree().change_scene_to_file("res://Scenes/HouseInterior.tscn")

func _on_door_area_body_exited(body):
	if body == player:
		end_dialogue()

func _notification(what):
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		if fade_overlay:
			fade_overlay.size = get_viewport_rect().size
