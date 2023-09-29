extends Area3D

class_name Balloon

signal defeat(balloon: Balloon)
signal miss(balloon: Balloon)

enum BalloonColor {RED,GREEN,BLUE}

const BalloonColorString = {
	RED = "ff231b",
	GREEN = "00bd5f",
	BLUE = "0037ff"
}

@export var color: BalloonColor = BalloonColor.RED
var _life_points: int = 1
var _vertical_speed: float = 0.3
var _increase_size: float = 0.2
var hit_score: int = 1
var miss_score: int = 0

@onready var _material = $Model.mesh.material
@onready var _life_time: Timer = $Timer

func _ready() -> void:
	var material_color = BalloonColorString.RED
	match color:
		BalloonColor.RED :
			_life_time.wait_time = 20
		BalloonColor.GREEN :
			material_color = BalloonColorString.GREEN
			_life_points = 2
			_vertical_speed = 0.5
			_life_time.wait_time = 11
			hit_score = 3
			miss_score = -1
		BalloonColor.BLUE :
			material_color = BalloonColorString.BLUE
			_life_points = 3
			_vertical_speed = 1
			_life_time.wait_time = 6
			hit_score = 5
			miss_score = -2

	_material.albedo_color = Color.from_string(material_color, Color.YELLOW)
	_life_time.one_shot = true
	_life_time.start()

func _process(delta):
	position.y += _vertical_speed * delta

func _on_input_event(_camera:Node, event:InputEvent, _position:Vector3, _normal:Vector3, _shape_idx:int) -> void:
	if event.is_action_pressed("Shoot"):
		scale += Vector3.ONE * _increase_size
		_life_points -= 1

		if _life_points <= 0:
			defeat.emit(self)
			queue_free()

func _on_timer_timeout() -> void:
	miss.emit(self)
	queue_free()
