shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise: repeat_enable;
uniform float speed: hint_range(0.005, 0.1) = 0.01;
uniform float strength: hint_range(0.005, 0.1) = 0.01;

uniform float speedX = 0.3;
uniform float disX =50.0;

uniform float speedY = 0.3;
uniform float disY = 30.0;

uniform vec2 offset = vec2(0.0, 0.0);


void fragment(){
	float noise_value = texture(noise, UV + TIME * speed).r;
	COLOR = texture(SCREEN_TEXTURE, (SCREEN_UV - strength/2.0) + vec2(noise_value) * strength);
}

void vertex() {
	float sinX = (TIME * speedX) + offset.x+offset.y;
	float varX = (sin(sinX)  + sin(sinX * 2.0) + sin(sinX * 6.0))  * disX /20.0 ;
	
	
	float sinY = (TIME +offset.x) * speedY;
	float varY = (cos(sinY)  + cos(sinY * 2.0))  * disY /20.0;
	
	float time_factor = sin(((UV.x+UV.y)*3.0+TIME*0.001)*1000.0)*10.0;
	
	float wave_from_x = (cos(offset.x * 100.0 )/1000.0);
	VERTEX.x +=  time_factor + varX*(UV.x -0.5);
	
	VERTEX.y += (varY) * (UV.y - 0.5);
}