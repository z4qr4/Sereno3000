shader_type canvas_item;

const vec2 res = vec2(320.0/1.0, 160.0/1.0);
const float hardScan = -10.0;
const float hardPix = -4.0;
const float hardBloomScan = -2.0;
const float hardBloomPix = -1.5;
const float bloomAmount = 1.0/16.0;
const vec2 warp = vec2(1.0/64.0, 1.0/24.0);
const float maskDark = 0.5;
const float maskLight = 1.5;

// sRGB to Linear.
// Assuing using sRGB typed textures this should not be needed.
float ToLinear1(float c){return(c<=0.04045)?c/12.92:pow((c+0.055)/1.055,2.4);}
vec3 ToLinear(vec3 c){return vec3(ToLinear1(c.r),ToLinear1(c.g),ToLinear1(c.b));}

// Linear to sRGB.
// Assuing using sRGB typed textures this should not be needed.
float ToSrgb1(float c){return(c<0.0031308?c*12.92:1.055*pow(c,0.41666)-0.055);}
vec3 ToSrgb(vec3 c){return vec3(ToSrgb1(c.r),ToSrgb1(c.g),ToSrgb1(c.b));}

void fragment(){
	vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV);
}
