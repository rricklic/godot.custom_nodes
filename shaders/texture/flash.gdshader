shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(0.0, 0.75, 0.25, 1.0);
uniform float flash_amount : hint_range(0.0, 1.0) = 0.5;

void fragment()
{
	vec4 pixel_color = texture(TEXTURE, UV); // Sample this pixel
	COLOR = mix(pixel_color, flash_color, flash_amount); // Set this pixel
	COLOR.a *= pixel_color.a; // Preserve alpha
}