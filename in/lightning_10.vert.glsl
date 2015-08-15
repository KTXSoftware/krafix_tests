#version 100

attribute vec3 vertexPosition;
attribute vec4 vertexColor;
attribute vec2 texPosition;

uniform mat4 projectionMatrix;

varying vec4 v_color;
varying vec2 v_texCoords;

void kore()
{
	v_color = vertexColor;
	v_texCoords = texPosition;
	gl_Position = projectionMatrix * vec4(vertexPosition, 1.0);
}