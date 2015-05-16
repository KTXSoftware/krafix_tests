#ifdef GL_ES
precision highp float;
#endif

attribute vec3 vertexPosition;
attribute vec2 texPosition;
attribute vec3 normalPosition;
attribute vec4 vertexColor;

uniform mat4 mvpMatrix;
uniform vec3 billboardCenterWorld;
uniform vec3 billboardSize;
uniform vec3 camRightWorld;
uniform vec3 camUpWorld;

varying vec2 texCoord;
varying vec4 color;

void kore() {

	vec3 vertexPosWorld =
    	billboardCenterWorld
    	+ camRightWorld * vertexPosition.x * billboardSize.x
    	+ camUpWorld * vertexPosition.y * billboardSize.y;

	gl_Position = mvpMatrix * vec4(vertexPosWorld, 1.0);
	
	color = vertexColor;
	texCoord = texPosition;
}
