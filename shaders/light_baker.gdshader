shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(1.0,1.0,1.0,1.0);
uniform float radius : hint_range(0.0,1.0) = 0.5;
uniform float falloff : hint_range(0.1,5.0) = 2.0;
uniform float softness : hint_range(0.0,1.0) = 0.2;

uniform bool cone_enabled = false;
uniform float cone_angle : hint_range(0,180) = 60.0;
uniform float cone_softness : hint_range(0.0,1.0) = 0.2;

void fragment() {
	vec2 uv = UV - vec2(0.5);
	float dist = length(uv);

	// radial falloff
	float radial = 1.0 - smoothstep(radius-softness, radius, dist);
	radial = pow(radial, falloff);

	// flashlight cone
	float cone = 1.0;
	if (cone_enabled) {
		float angle = degrees(atan(uv.y, uv.x));
		float half_fov = cone_angle*0.5;
		cone = 1.0 - smoothstep(half_fov, half_fov + cone_softness*180.0, abs(angle));
	}

	float intensity = radial * cone;
	COLOR = vec4(light_color.rgb, intensity * light_color.a);
}