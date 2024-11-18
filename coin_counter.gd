extends Sprite2D

var W_size = Vector2(0, 0)

@onready var coin_Counter = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	W_size = DisplayServer.window_get_size()
	W_size = Vector2(W_size[0] / 1650.0,W_size[1] / 880.0)
	coin_Counter.set_scale(W_size)