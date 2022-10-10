extends CharacterBody2D

@onready var grid = self.get_parent()

func _physics_process(delta):
	move_and_slide()

func _input(event):
	if event.is_pressed():
		print_debug(position)
	if event.is_action_pressed("up"):
		update_direction("up")
		position = grid.move(self, Vector2i.UP)
	if event.is_action_pressed("down"):
			update_direction("down")
			position = grid.move(self, Vector2i.DOWN)
	if event.is_action_pressed("left"):
			update_direction("left")
			position = grid.move(self, Vector2i.LEFT)
	if event.is_action_pressed("right"):
			update_direction("right")
			position = grid.move(self, Vector2i.RIGHT)
	if event.is_pressed():
		print_debug(position)

func update_direction(direction: String):
	$AnimatedSprite2d.animation = direction
