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
var near_captain := false
var near_supply_chest: bool = false
var found_supplies: bool = false

func _ready():
	dialogue_box.visible = false
	MusicManager.play_music("res://Audio/ashport.ogg", -8.0)
	
	if get_tree().has_meta("main_spawn_marker"):
		var marker_name = get_tree().get_meta("main_spawn_marker")
		get_tree().remove_meta("main_spawn_marker")
		
		var spawn_marker = get_node_or_null(marker_name)
		if spawn_marker != null:
			player.global_position = spawn_marker.global_position
	fade_overlay.position = Vector2.ZERO
	fade_overlay.size = get_viewport_rect().size
	fade_overlay.color = Color.BLACK
	fade_overlay.modulate.a = 1.0

	var tween := create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0.0, 1.5)
	await tween.finished

	if get_tree().has_meta("play_ashport_intro_dialogue") and get_tree().get_meta("play_ashport_intro_dialogue") == true:
		get_tree().remove_meta("play_ashport_intro_dialogue")
		start_dialogue([
			"The captain coughs seawater from his throat and looks toward the wreck.",
			"\"Well... she has looked better.\"",
			"\"We are alive. That is the first bit of luck.\"",
			"\"The second would be finding something useful before nightfall.\"",
			"\"Check the shore. Barrels, crates, anything the tide gave back.\"",
			"\"I will see what can be saved from the boat.\""
	])

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if dialogue_active:
			advance_dialogue()
		else:
			if near_captain:
				if found_supplies:
					start_dialogue([
						"The captain checks over the supplies and gives a tired little nod.",
						"\"Well, this helps. Not enough to get us sailing, but enough to keep us from looking completely hopeless.\"",
						"\"The boat needs more than a few tools and wishful thinking.\"",
						"\"Go on into Ashport. Get your footing. I will see what can be saved here.\""
					])
				else:
					start_dialogue([
						"The captain looks over the wrecked boat and sighs.",
						"\"Well... she has looked better.\"",
						"\"The tide brought us in, but it may not let us leave just yet.\"",
						"\"Go on ahead and see if you can find any supplies. I will see what can be saved here.\""
					])
			elif near_supply_chest:
				found_supplies = true
				start_dialogue([
					"You find a damp supply chest.",
					"Most of it is ruined, but a few tools might still be useful."
				])
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

#Captain dialogue area
func _on_captain_talk_area_body_entered(body):
	if body.name == "Player":
		near_captain = true


func _on_captain_talk_area_body_exited(body):
	if body.name == "Player":
		near_captain = false


func _on_supply_chest_inspect_area_body_entered(body):
	if body.name == "Player":
		near_supply_chest = true


func _on_supply_chest_inspect_area_body_exited(body):
	if body.name == "Player":
		near_supply_chest = false
