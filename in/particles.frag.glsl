#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D tex;
uniform bool texturing;

varying vec2 texCoord;
varying vec4 color;

void kore() {

	if (texturing) {
		gl_FragColor = texture2D(tex, texCoord);
	}
	else {
		gl_FragColor = vec4(color.rgb, 1.0);;
	}
}
