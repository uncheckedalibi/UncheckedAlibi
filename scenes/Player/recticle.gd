extends TextureRect

@export var reticle_transparency := 1.0:
	set(v):
		reticle_transparency = v
		if !is_inside_tree(): return
		modulate.a = v
@export var reticle_size := 64:
	set(v):
		reticle_size = v
		if !is_inside_tree(): return
		size = Vector2(v,v)
		position = (get_viewport_rect().size - Vector2(v,v)) / 2

func _ready():
	reticle_transparency = reticle_transparency
	reticle_size = reticle_size
