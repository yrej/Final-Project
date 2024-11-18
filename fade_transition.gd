extends Control

@onready var CenterTex = $Center
@onready var BackTex = $backdrop
@onready var animation_p = $transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CenterTex.visible = false
	BackTex.visible = false

func set_next_an(fading_out : bool):
	if(fading_out):
		CenterTex.visible = true
		BackTex.visible = true
		animation_p.queue("FADE_OUT")
	else:
		CenterTex.visible = true
		BackTex.visible = true
		animation_p.queue("FADE_IN")
