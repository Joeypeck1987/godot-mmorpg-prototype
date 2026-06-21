extends CharacterBody2D

@export var speed: float = 120.0
@export var animation_prefix: String = ""

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(delta):
	var direction = Vector2.ZERO

	var horizontal_input = 0
	var vertical_input = 0

	if Input.is_action_pressed("move_right"):
		horizontal_input += 1

	if Input.is_action_pressed("move_left"):
		horizontal_input -= 1

	if Input.is_action_pressed("move_down"):
		vertical_input += 1

	if Input.is_action_pressed("move_up"):
		vertical_input -= 1

	# Prevent diagonal movement.
	# Horizontal movement takes priority if both are pressed.
	if horizontal_input != 0:
		direction.x = horizontal_input

		if horizontal_input > 0:
			last_direction = "right"
		else:
			last_direction = "left"

	elif vertical_input != 0:
		direction.y = vertical_input

		if vertical_input > 0:
			last_direction = "down"
		else:
			last_direction = "up"

	velocity = direction * speed

	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2):
	var animation_type = "idle"

	if direction != Vector2.ZERO:
		animation_type = "walk"

	var animation_name = animation_prefix + animation_type + "_" + last_direction
	animated_sprite.play(animation_name)
