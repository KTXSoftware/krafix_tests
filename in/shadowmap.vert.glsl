#ifdef GL_ES
precision highp float;
#endif

attribute vec3 vertexPosition;
attribute vec2 texPosition;
attribute vec3 normalPosition;
attribute vec4 vertexColor;

uniform mat4 dbMVP;

varying vec4 position;

void kore() {

	gl_Position = dbMVP * vec4(vertexPosition, 1.0);
	position = gl_Position;
}
