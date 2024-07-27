shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise;
uniform vec4 color: source_color;
uniform float opacity: hint_range(0.0, 1.) = 0.5;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 noise_texture = texture(noise, UV);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV)*noise_texture;
	COLOR.a *= opacity;
	COLOR = clamp(COLOR, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
