#ifdef GL_ES
precision mediump float;
#endif

uniform float roughness;
uniform vec4 fogColor;

varying vec3 vposition;
varying vec4 matcolor;
varying vec4 viewSpacePosition;

float getFogFactor(float fogCoord) { 
	float result = 0.0; 
	float density = 0.05;
	result = exp(-density * fogCoord);   
	result = 1.0 - clamp(result, 0.0, 1.0); 
	return result; 
}

void kore() {

	vec4 outcolor;

	if (roughness > 0.0 && vposition.y < (roughness * 3.40)) {
		outcolor = matcolor + 0.07;
	}
	else {
		outcolor = matcolor;
	}

	gl_FragColor = vec4(outcolor.rgb, 1.0);

	if (viewSpacePosition.z < -40.0) {
		float fogCoord = abs((viewSpacePosition.z + 40.0) / viewSpacePosition.w);
		gl_FragColor = mix(gl_FragColor, fogColor, getFogFactor(fogCoord));
	}
}
