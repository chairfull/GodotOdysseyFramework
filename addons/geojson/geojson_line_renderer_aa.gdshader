shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;

uniform float line_width_px : hint_range(0.5,200.0) = 4.0;
uniform vec2 viewport_size = vec2(1920.0,1080.0);

varying float v_half_width; // pass half-width in pixels to fragment

void vertex() {
    vec3 view_pos = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec4 clip_pos = PROJECTION_MATRIX * vec4(view_pos, 1.0);

    vec3 tangent_view = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    vec3 cam_dir = normalize(-view_pos);
    vec3 side_view = cross(cam_dir, tangent_view);
    if (length(side_view) < 1e-6)
        side_view = cross(vec3(0.0,1.0,0.0), tangent_view);
    side_view = normalize(side_view);

    vec4 clip_side = PROJECTION_MATRIX * vec4(view_pos + side_view, 1.0);
    vec2 ndc_center = clip_pos.xy / clip_pos.w;
    vec2 ndc_side   = clip_side.xy / clip_side.w;
    vec2 px_center  = (ndc_center * 0.5 + 0.5) * viewport_size;
    vec2 px_side    = (ndc_side   * 0.5 + 0.5) * viewport_size;

    vec2 dir_px = px_side - px_center;
    float len_px = max(length(dir_px), 1e-6);
    vec2 dir_px_n = dir_px / len_px;

    float half_w = line_width_px * 0.5;
    v_half_width = half_w;

    vec2 offset_px = dir_px_n * half_w * UV.x;
    vec2 offset_ndc = (offset_px / viewport_size) * 2.0;
    clip_pos.xy += offset_ndc * clip_pos.w;
    POSITION = clip_pos;
}

void fragment() {
    float alpha = 1.0 - abs(UV.x) * 2.0;
    alpha = clamp(alpha, 0.0, 1.0);
    ALBEDO *= COLOR.rgb;
    ALPHA = alpha;
}