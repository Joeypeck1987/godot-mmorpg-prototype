extends Control

@onready var boat_background: TextureRect = $BoatBackground
@onready var captain_intro_sprite: TextureRect = $CaptainIntroSprite
@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText
@onready var fade_overlay: ColorRect = $FadeOverlay

var wreck_sfx_player: AudioStreamPlayer

var wreck_sounds: Array[AudioStream] = [
	preload("res://Audio/wreck_wave_swell_original.wav"),
	preload("res://Audio/wreck_wood_crack_original.wav"),
	preload("res://Audio/wreck_crash_impact_original.wav"),
	preload("res://Audio/wreck_low_bell_original.wav")
]

var intro_lines := [
	"Easy now. The tide carried you farther than most folk dare go.",
	"The shore ahead is Ashport.",
	"...Wait.",
	"The current is all wrong.",
	"Brace yourself!"
]

var wreck_lines := [
	"The deck lurches beneath you.",
	"Wood cracks.",
	"Cold water rushes in.",
	"For a moment, there is only the bell."
]

var dialogue_index := 0
var dialogue_started := false
var transitioning := false


func _ready() -> void:
	boat_background.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	captain_intro_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	dialogue_box.visible = false
	dialogue_text.text = intro_lines[dialogue_index]
	
	fade_overlay.color = Color.BLACK
	fade_overlay.modulate.a = 1.0
	
	wreck_sfx_player = AudioStreamPlayer.new()
	add_child(wreck_sfx_player)
	wreck_sfx_player.volume_db = -6.0
	
	MusicManager.play_music("res://Audio/intro.ogg", -10.0)
	
	fade_in_intro()


func fade_in_intro() -> void:
	var tween := create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0.0, 1.5)
	await tween.finished
	
	dialogue_box.visible = true
	dialogue_started = true


func _unhandled_input(event: InputEvent) -> void:
	if not dialogue_started:
		return
	
	if transitioning:
		return
	
	if event.is_action_pressed("interact"):
		advance_dialogue()


func advance_dialogue() -> void:
	dialogue_index += 1
	
	if dialogue_index >= intro_lines.size():
		transition_to_ashport()
		return
	
	dialogue_text.text = intro_lines[dialogue_index]


func transition_to_ashport() -> void:
	transitioning = true
	dialogue_box.visible = false
	
	var tween := create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 1.0, 1.5)
	await tween.finished
	
	var wreck_label := Label.new()
	add_child(wreck_label)
	
	wreck_label.text = ""
	wreck_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wreck_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	wreck_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	wreck_label.add_theme_color_override("font_color", Color.WHITE)
	wreck_label.add_theme_font_size_override("font_size", 22)
	
	wreck_label.anchor_left = 0.0
	wreck_label.anchor_top = 0.0
	wreck_label.anchor_right = 1.0
	wreck_label.anchor_bottom = 1.0
	wreck_label.offset_left = 40
	wreck_label.offset_top = 0
	wreck_label.offset_right = -40
	wreck_label.offset_bottom = 0
	
	for i in wreck_lines.size():
		wreck_label.text = wreck_lines[i]
		play_wreck_sound(i)
		await wait_for_interact()
	
	wreck_label.queue_free()
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func wait_for_interact() -> void:
	while true:
		await get_tree().process_frame
		
		if Input.is_action_just_pressed("interact"):
			return

func play_wreck_sound(index: int) -> void:
	if index >= wreck_sounds.size():
		return
	
	wreck_sfx_player.stream = wreck_sounds[index]
	wreck_sfx_player.play()
