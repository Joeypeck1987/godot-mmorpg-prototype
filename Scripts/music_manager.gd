extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	var music = load("res://Audio/home.ogg")
	music_player.stream = music
	music_player.volume_db = -8
	music_player.autoplay = false

	if music_player.stream:
		music_player.stream.loop = true

	music_player.play()

func play_home_theme():
	if not music_player.playing:
		music_player.play()
