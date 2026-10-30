extends StaticBody3D

@onready var prompt_label: Label3D = $Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func interact():
	print("Picked up item")
	queue_free()

func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false
