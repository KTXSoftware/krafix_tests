#version 450

uniform samplerVideo tex;
in vec2 texCoord;
in vec4 color;

void main() {
	vec4 texcolor = texture(tex, texCoord) * color;
	texcolor.rgb *= color.a;
	gl_FragColor = texcolor;
}
