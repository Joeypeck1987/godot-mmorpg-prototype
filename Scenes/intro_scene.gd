extends Control

@onready var boat_background: TextureRect = $BoatBackground
@onready var captain_intro_sprite: TextureRect = $CaptainIntroSprite
@onready var dialogue_box: Panel = $DialogueLayer/DialogueBox
@onready var dialogue_text: Label = $DialogueLayer/DialogueBox/DialogueText
@onready var fade_overlay: ColorRect = $FadeOverlay

var intro_lines := [
	"Easy now. The tide carried you farther than most folk dare go.",
	"The shore ahead is Ashport.",
	"But keep your eyes open...",
	"...",
	"The bells have started ringing again.",
	"...",
	"Dead men walk... Beasts change shape... Old roads lead where they should not...",
	"...Some hear the bells and keep walking...",
	"We call those ones Wayfarers.",
	"Now then... let us get you ashore."
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
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
