// This file was modified by Vedant Chaudhari with permission from author

/*
	Copyright 2011-2018 Daniel S. Buckstein

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

/*
	animal3D SDK: Minimal 3D Animation Framework
	By Daniel S. Buckstein
	
	passDiffuseComponents_transform_vs4x.glsl
	Pass variables pertinent to diffuse shading.
*/

#version 410

// ****TO-DO: 
//	1) declare attribute for normal
//	2) declare uniforms for variables in code pertinent to lighting
//	3) declare varyings to pass relevant data (per-vertex vs. per-fragment)
//	4) pass data to next shader

layout (location = 0) in vec4 aPosition;

// (1)
layout (location = 2) in vec3 aNormal;

uniform mat4 uMVP;
// (2)
uniform vec4 uLightPos_obj;

// (3a)
// per-vertex
//out float vShading;

// (3b)
out vec3 vPassNormal;
out vec3 vPassLight;

void main()
{
	gl_Position = uMVP * aPosition;

	// (4a)
	//vec3 L = normalize(uLightPos_obj - aPosition).xyz;
	//vec3 N = normalize(aNormal);
	//float diffuse = dot(N, L);
	//vShading = diffuse;

	// (4)
	vPassNormal = aNormal;
	vPassLight = uLightPos_obj.xyz - aPosition.xyz;
}
