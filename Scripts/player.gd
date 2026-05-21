extends CharacterBody2D

@export var speed: float = 120.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
		last_direction = "right"

	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		last_direction = "left"

	if Input.is_action_pressed("move_down"):
		direction.y += 1
		last_direction = "down"

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		last_direction = "up"

	direction = direction.normalized()
	velocity = direction * speed

	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		animated_sprite.play("idle_" + last_direction)
	else:
		animated_sprite.play("walk_" + last_direction)
