#version 100

attribute vec4 a_position;
attribute vec2 a_texCoord;

varying vec2 v_texCoords0;
varying vec2 v_texCoords1;
varying vec2 v_texCoords2;
varying vec2 v_texCoords3;
varying vec2 v_texCoords4;

uniform vec2  dir;

uniform float fboW;
uniform float fboH;

float lastFboW = -1.0;
float lastFboH = -1.0;

vec2 futher;
vec2 closer;

uniform mat4 projectionMatrix;

void kore()
{
	if(fboH != lastFboH || fboW != lastFboW) {
		futher = vec2(3.2307692308 / fboW, 3.2307692308 / fboH );
		closer = vec2(1.3846153846 / fboW, 1.3846153846 / fboH );

		lastFboH = fboH;
		lastFboW = fboW;
	}

	vec2 f = futher * dir;
	vec2 c = closer * dir;
	v_texCoords0 = a_texCoord - f;
	v_texCoords1 = a_texCoord - c;
	v_texCoords2 = a_texCoord;
	v_texCoords3 = a_texCoord + c;
	v_texCoords4 = a_texCoord + f;
	gl_Position = projectionMatrix * a_position;
}