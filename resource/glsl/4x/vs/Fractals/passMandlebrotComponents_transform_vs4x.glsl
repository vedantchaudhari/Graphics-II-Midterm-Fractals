/*
* Team Members:
*				Vedant Chaudhari 1530277
*				Aaron Hamilton
*
* Course Code: EGP-300
* Section: 01
* Project Name: Fractals Midterm
* Certificate of Authenticity :
*		We certify that this work is entirely our own.  The assessor of this 
		project may reproduce this project and provide copies to other academic staff, 
		and/or communicate a copy of this project to a plagiarism-checking service, which 
		may retain a copy of the project on its database.
*/

// Author: Vedant Chaudhari

#version 410

layout (location = 0) in vec4 aPosition;
layout (location = 2) in vec3 aNormal;
layout (location = 8) in vec2 aTexcoord;

uniform mat4 uMVP;

uniform vec4 uLightPos_obj;
uniform vec4 uEyePos_obj;

out vec2 vPassTexcoord;
out vec3 vPassNormal;
out vec3 vPassLight;
out vec3 vPassView;

void main()
{
	// gl_Position = uEyePos_obj * aNormal;
	// 2D projection
	gl_Position = vec4(aTexcoord.xy - 0.5, 0.0, 0.5);

	vPassTexcoord = aTexcoord;
	vPassNormal = aNormal;
	vPassLight = uLightPos_obj.xyz - aPosition.xyz;
	vPassView = uEyePos_obj.xyz - aPosition.xyz;
}