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
uniform vec3 billboardCenterWorld;
uniform vec3 billboardSize;
uniform vec3 camRightWorld;
uniform vec3 camUpWorld;

varying vec2 texCoord;
varying vec4 color;
varying vec3 normal;

void kore() {

	vec3 vertexPosWorld =
    	billboardCenterWorld
    	+ camRightWorld * pos.x * billboardSize.x
    	+ camUpWorld * pos.y * billboardSize.y;

	gl_Position = P * V * M * vec4(vertexPosWorld, 1.0);
	
	texCoord = tex;
	color = col;
}
