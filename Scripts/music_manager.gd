extends Node

var music_player: AudioStreamPlayer
var current_music_path: String = ""


func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.volume_db = -8


func play_music(music_path: String, volume_db_value: float = -8.0) -> void:
	if current_music_path == music_path and music_player.playing:
		return

	var music = load(music_path)

	if music == null:
		print("Could not load music: ", music_path)
		return

	music_player.stop()
	music_player.stream = music
	music_player.volume_db = volume_db_value

	if music_player.stream:
		music_player.stream.loop = true

	music_player.play()
	current_music_path = music_path


func stop_music() -> void:
	if music_player:
		music_player.stop()
		music_player.stream = null
		current_music_path = ""
