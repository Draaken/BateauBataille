shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform float speed: hint_range(0.0, 0.1) = 0.01;
uniform float strength: hint_range(0.005, 0.1) = 0.01;
uniform sampler2D noise_foam: repeat_enable;
uniform sampler2D noise_foam2: repeat_enable;
uniform sampler2D noise_deform: repeat_enable;
uniform sampler2D noise_displace : repeat_enable;
uniform float foam_width: hint_range(0.0, 2.0) = 0.5;
uniform float height: hint_range(0.0, 1.0) = 0.5;
uniform float deformation: hint_range(0.0, 10.0) = 3.0;
uniform float scarcity: hint_range(0.0, 1.0) = 0.1;

uniform float speedX = 0.3;
uniform float disX =50.0;

uniform float speedY = 0.3;
uniform float disY = 30.0;

uniform vec2 offset = vec2(0.0, 0.0);

void vertex() {
	float sinX = (TIME * speedX) + offset.x+offset.y;
	float varX = (sin(sinX)  + sin(sinX * 2.0) + sin(sinX * 6.0))  * disX /20.0 ;
	
	
	float sinY = (TIME +offset.x) * speedY;
	float varY = (cos(sinY)  + cos(sinY * 2.0))  * disY /20.0;
	
	float time_factor = sin(((UV.x+UV.y)*3.0+TIME*0.001)*1000.0)*10.0;
	
	float wave_from_x = (cos(offset.x * 100.0 )/1000.0);
	VERTEX.x +=  time_factor*2.0 + varX*(UV.x -0.5);
	
	VERTEX.y += (varY) * (UV.y - 0.5);
}

void fragment(){
	float time_height = height + sin(TIME*speed)/100.0 + cos(TIME*speed/1000.0 + 150.0)/20.0 ;
	float noise_deform_value = texture(noise_deform, UV + TIME * speed).r;
	float xModifier = sin(TIME) * speed/2.0 *deformation *noise_deform_value/2.0;
	float yModifier = tan(cos(TIME+UV.x+UV.y)) * speed/2.0 *deformation *noise_deform_value/2.0;
	float noise_foam_value = texture(noise_foam, UV+ sin(TIME) * speed*noise_deform_value).r;
	noise_foam_value *= texture(noise_foam2, UV + vec2(xModifier, yModifier)).r;
	noise_foam_value *= smoothstep(scarcity, 1.0, texture(noise_displace, (UV + TIME*speed*2.0)).r);
	
	float alpha = 0.1;
	COLOR.a = step(time_height ,noise_foam_value) * step(noise_foam_value, time_height + foam_width/10.0) * alpha;
	//COLOR.rgb *= texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	
}