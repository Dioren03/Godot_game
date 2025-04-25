extends CharacterBody2D

@export var speed := 200
@export var jump_force := -400
@export var gravity := 900

@onready var sprite := $AnimatedSprite2D

func _physics_process(delta):
	var direction := 0.0

	# Input
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	velocity.x = direction * speed

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		sprite.play("jump")

	# Movement
	move_and_slide()

	# Flip
	if direction != 0:
		sprite.flip_h = direction < 0

	# Animations
	if Input.is_action_just_pressed("attack"):
		sprite.play("attack")
	elif Input.is_action_just_pressed("block"):
		sprite.play("block")
	elif Input.is_action_just_pressed("hit"):
		sprite.play("hit")
	elif Input.is_action_just_pressed("death"):
		sprite.play("death")
	elif Input.is_action_just_pressed("stop"):
		sprite.play("stop")
	elif is_on_floor():
		if velocity.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
