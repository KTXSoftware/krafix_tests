#ifdef GL_ES
precision highp float;
#endif

attribute vec3 pos;
attribute vec2 tex;
attribute vec3 nor;
attribute vec4 col;

uniform mat4 M;
uniform mat4 V;
uniform mat4 P;
uniform mat4 dbMVP;
uniform vec4 color;
uniform vec4 diffuse_color;

varying vec3 position;
varying vec2 texCoord;
varying vec3 normal;
varying vec4 lPos;
varying vec4 matcolor;

void kore() {

	vec4 mpos = M * vec4(pos.x, pos.y, pos.z, 1.0);
	gl_Position = P * V * mpos;
	position = mpos.xyz / mpos.w;
	texCoord = tex;
	normal = normalize((M * vec4(nor, 0.0)).xyz);

	lPos = dbMVP * vec4(pos.x, pos.y, pos.z, 1.0);

	matcolor = diffuse_color * col * color;
}
