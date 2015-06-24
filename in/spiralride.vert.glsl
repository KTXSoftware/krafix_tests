#ifdef GL_ES
precision highp float;
#endif

attribute vec3 pos;
attribute vec4 col;

uniform mat4 M;
uniform mat4 V;
uniform mat4 P;
uniform vec4 color;
uniform bool useColor;
uniform bool highlight;
uniform bool oneColor;

varying vec3 vposition;
varying vec4 matcolor;
varying vec4 viewSpacePosition;

void kore() {

	vposition = vec3(pos.x, pos.y, pos.z);
	vec4 mpos = M * vec4(pos.x, pos.y, pos.z, 1.0);
	gl_Position = P * V * mpos;
	viewSpacePosition = V * mpos;

	if (!oneColor) {
		matcolor = col;

		if (useColor) {
			matcolor *= color;

			if (highlight) {
				matcolor += 0.07;
			}
		}		
	}
	else {
		matcolor = color;
	}
}
