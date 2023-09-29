extends Node3D

class_name BalloonManager

var score: int = 0
var level: int = 1
var goal: int = 20
var dificulty: int = 0
var balloons: int = 0
var max_balloons: int = 10

@onready var balloon_scene = preload("res://Shooting/balloon.tscn")

func reset_level() -> void :
	score = 0
	level = 1
	dificulty = 0
	balloons = 0
	max_balloons = 10
	_set_level_label()
	_set_goal_label()

func next_level() -> void :
	score += 10 * level
	dificulty = 0
	level += 1
	max_balloons += level
	goal *= level
	_set_level_label()
	_set_goal_label()

func spawn_balloon() -> void :
	if balloons >= max_balloons:
		return

	var balloon_type_seed: int = randi_range(0, 100) % level
	var balloon : Balloon = balloon_scene.instantiate()

	balloon.color = balloon_type_seed as Balloon.BalloonColor
	balloon.position.x = randf_range(-4.5, 4.5)
	balloon.position.y = randf_range(-3.8, -3.2)
	add_child(balloon)
	balloon.defeat.connect(_defeated_balloon)
	balloon.miss.connect(_missed_balloon)
	balloons += 1

func _process(_delta: float) -> void:
	spawn_balloon()
	if score >= goal or Input.is_action_just_pressed("Next"):
		next_level()

func _ready() -> void:
	reset_level()

func _defeated_balloon(balloon: Balloon):
	balloons -= 1
	score += balloon.hit_score
	_set_score_label()

func _missed_balloon(balloon: Balloon):
	balloons -= 1
	score += balloon.miss_score
	_set_score_label()

func _set_score_label():
	$Score.text = str("Score: ", score)

func _set_level_label():
	$Level.text = str("Level: ", level)

func _set_goal_label():
	$Goal.text = str("Next Level on: ", goal)
