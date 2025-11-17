shader_type spatial;
render_mode unshaded;

uniform vec3 target_position = vec3(0.0);
uniform float max_distance : hint_range(0.1, 50.0) = 10.0;

varying vec3 world_pos;
varying vec3 world_normal;

void vertex() {
    world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    world_normal = (MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz;
}

void fragment() {
	vec3 norm = normalize(world_normal);
	float dist = distance(world_pos, target_position);
	float v = clamp(dist / max_distance, 0.0, 1.0);
	// Simple spherical pack: phi (azim) in G, theta (elev) in B; dist in R
	float phi = atan(norm.z, norm.x) / (2.0 * PI) + 0.5;  // [0,1]
	float theta = acos(norm.y) / PI;  // [0,1]
	ALBEDO = vec3(v, phi, theta);
}