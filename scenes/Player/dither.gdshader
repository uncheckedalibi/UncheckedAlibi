shader_type canvas_item;

uniform float scale = 1.0;
uniform sampler2D dither_texture : filter_nearest;
uniform vec4 dark_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

float vValue(vec3 rgb) {
	return max(rgb.r,max(rgb.g,rgb.b));
}

vec3 maxBrightness(vec3 rgb) {
	return rgb / vValue(rgb);
}

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	vec3 c = texture(screen_texture, floor(SCREEN_UV / (SCREEN_PIXEL_SIZE * scale)) * SCREEN_PIXEL_SIZE * scale).rgb;
	ivec2 pixel = ivec2(floor(SCREEN_UV / SCREEN_PIXEL_SIZE) / scale);
	ivec2 dither_size = textureSize(dither_texture, 0);
	vec2 i = vec2(float(int(pixel.x) % dither_size.x) / float(dither_size.x), 
		float(int(pixel.y) % dither_size.y) / float(dither_size.y));
	float v = texture(dither_texture, i).r;
	if (v <= vValue(c)) {
		c = maxBrightness(c);
	} else {
		c = dark_color.rgb;
	}
	COLOR = vec4(c, 1.0);
	if (vValue(color.rgb) < 0.01 || vValue(color.rgb) > 0.99) COLOR = color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
