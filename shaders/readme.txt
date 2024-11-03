texture() - function to manipulate texture: which texture, where to manipulate (UV coordinate e.g.: 0-1)
TEXTURE - (constant) texture of this shader
UV - (constant) UV coordinate of this sampling
COLOR - the color of this pixel
uniform - shader input constant value; can be set in IDE from "Shader Parameters"
hint_range() - define the valid values for a uniform
source_color - hint that IDE should only allow color
mix(source, dest, interpolation) - function to interpolate between source and destination color
