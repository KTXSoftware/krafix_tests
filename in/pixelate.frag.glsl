#version 120

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 texCoord;

uniform sampler2D tex;
uniform vec2 resolution;
uniform vec2 pixelSize; // 15.0
uniform float offset;



void kore() 
{ 
  
  vec3 tc = vec3(1.0, 0.0, 0.0);
  if (texCoord.x < (offset-0.005))
  {
    float dx = pixelSize.x*(1./resolution.x);
    float dy = pixelSize.y*(1./resolution.y);
    vec2 coord = vec2(dx*floor(texCoord.x/dx),
                      dy*floor(texCoord.y/dy));
    tc = texture2D(tex, coord).rgb;
  }
  else if (texCoord.x>=(offset+0.005))
  {
    tc = texture2D(tex, texCoord).rgb;
  }
	gl_FragColor = vec4(tc, 1.0);
}