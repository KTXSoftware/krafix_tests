#ifdef GL_ES
precision highp float;
#endif

#define SKINNING_TEXTURE_SIZE 2048.0 
#define BINDS_OFFSET		  1024.0

attribute vec3 vertexPosition;
attribute vec2 texPosition;
attribute vec3 normalPosition;
attribute vec4 vertexColor;
attribute vec4 bone;
attribute vec4 weight;

uniform mat4 mvpMatrix;
uniform mat4 dbmvpMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform bool lighting;
uniform bool rim;
uniform sampler2D skinning;

varying vec2 texCoord;
varying vec3 norm;
varying vec4 color;
varying vec4 shadowCoord;
varying vec4 viewSpacePos;

float packColor(vec4 color) {
    return color.r + color.g * 256.0 + color.b * 256.0 * 256.0;
}

vec4 skinningRead(float id) {

	float r = packColor(texture2D(skinning, vec2(0.0, ((id * 4.0 + 0.0) / (SKINNING_TEXTURE_SIZE * 4.0 - 1.0)))));
	float g = packColor(texture2D(skinning, vec2(0.0, ((id * 4.0 + 1.0) / (SKINNING_TEXTURE_SIZE * 4.0 - 1.0)))));
	float b = packColor(texture2D(skinning, vec2(0.0, ((id * 4.0 + 2.0) / (SKINNING_TEXTURE_SIZE * 4.0 - 1.0)))));
	float a = packColor(texture2D(skinning, vec2(0.0, ((id * 4.0 + 3.0) / (SKINNING_TEXTURE_SIZE * 4.0 - 1.0)))));

	vec4 res = vec4(r, g, b, a);
	//res = normalize(res);
	return res;
}

mat4 skinWorldMatrix() {
	
	float b;
	float o = BINDS_OFFSET;
	vec4 l0,l1,l2;
	
	b = (bone[0]) * 3.0; 			
	l0 = skinningRead(b); l1 = skinningRead(b+1.0); l2 = skinningRead(b+2.0);
	mat4 j0 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	l0 = skinningRead(b+o); l1 = skinningRead(b+1.0+o); l2 = skinningRead(b+2.0+o);
	mat4 b0 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	
	b = (bone[1]) * 3.0; 
	l0 = skinningRead(b); l1 = skinningRead(b+1.0); l2 = skinningRead(b+2.0);
	mat4 j1 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	l0 = skinningRead(b+o); l1 = skinningRead(b+1.0+o); l2 = skinningRead(b+2.0+o);
	mat4 b1 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	
	b = (bone[2]) * 3.0; 
	l0 = skinningRead(b); l1 = skinningRead(b+1.0); l2 = skinningRead(b+2.0);
	mat4 j2 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	l0 = skinningRead(b+o); l1 = skinningRead(b+1.0+o); l2 = skinningRead(b+2.0+o);
	mat4 b2 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	
	b = (bone[3]) * 3.0; 
	l0 = skinningRead(b); l1 = skinningRead(b+1.0); l2 = skinningRead(b+2.0);
	mat4 j3 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);			
	l0 = skinningRead(b+o); l1 = skinningRead(b+1.0+o); l2 = skinningRead(b+2.0+o);
	mat4 b3 = mat4(l0.x,l0.y,l0.z,l0.w, l1.x,l1.y,l1.z,l1.w, l2.x,l2.y,l2.z,l2.w, 0,0,0,1);
	
	return mat4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1);
	//return  ((b0 * j0) * weight[0]) +
	//        ((b1 * j1) * weight[1]) +
	//        ((b2 * j2) * weight[2]) +
	//        ((b3 * j3) * weight[3]);
}

void kore() {

	//vec4 hpos   = ((lv * wm) * ViewMatrix) * ProjectionMatrix;			
	//gl_Position = hpos;

	vec4 lv = vec4(vertexPosition, 1.0);
	vec3 ln = vec3(normalPosition);
	mat4 wm = (skinWorldMatrix());

	norm = ln * mat3(wm);
	//gl_Position = ((lv * wm) * viewMatrix) * projectionMatrix;
	gl_Position = projectionMatrix * viewMatrix * wm * lv;
	
	color = vertexColor;

	vec4 lightDir = vec4(0.3, 0.3, 0.3, 1.0);
	vec4 ambient = vec4(0.2, 0.2, 0.2, 1.0);
	ambient = ambient * color;
	vec4 diffuse = color;
	color = ambient + diffuse * dot(lightDir, vec4(normalPosition, 1.0));

	//norm = normalPosition;
	texCoord = texPosition;
}
