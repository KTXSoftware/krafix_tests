#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D tex;
uniform sampler2D shadowMap;
uniform bool texturing;

varying vec2 texCoord;
varying vec4 color;
varying vec4 shadowCoord;
varying vec4 viewSpacePos;

void kore() {

	if (texturing) {
		gl_FragColor = texture2D(tex, texCoord);
	}
	else {
		gl_FragColor = color;
	}
}
