shader_type spatial;
render_mode unshaded, cull_back;

void fragment() {
    ALBEDO *= COLOR.rgb;
    ALPHA = COLOR.a;
}