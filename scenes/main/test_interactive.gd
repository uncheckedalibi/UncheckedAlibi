extends StaticBody3D


@onready var prompt_label: Label3D = $Label3D

func _ready() -> void:
	prompt_label.hide()

func _process(delta: float) -> void:
	pass
	
func interact():
	print("Picked up item")
	queue_free()

func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false
