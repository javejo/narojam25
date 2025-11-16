shader_type canvas_item;

uniform vec2 direction;
uniform float speed;
varying vec4 modulate;

void vertex() {
	// Called for every vertex the material is visible on.
	modulate = COLOR;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 move = direction * TIME * speed;
	COLOR = texture(TEXTURE, UV+move) * modulate;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
