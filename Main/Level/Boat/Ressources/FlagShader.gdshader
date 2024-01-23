shader_type canvas_item;
void fragment(){
  COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}
void vertex() {
    float time = TIME * 5.0;
    VERTEX.x += cos(time) * 3.0;

	float pivot = 1.0;
	float pivot_angle = cos(time) * 0.1 * pivot;
	mat2 rotation_matrix = mat2(vec2(cos(pivot_angle), -sin(pivot_angle)), vec2(sin(pivot_angle), cos(pivot_angle)));
	VERTEX.xy = rotation_matrix * VERTEX.xy;
//
	float body = (VERTEX.y);
	VERTEX.x += cos((time*5.0 + body)*0.2) * 2.0;
}