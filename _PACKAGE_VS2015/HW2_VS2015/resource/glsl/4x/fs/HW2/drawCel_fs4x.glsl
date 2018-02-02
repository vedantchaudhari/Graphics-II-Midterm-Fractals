/*
* Team Members:
*				Vedant Chaudhari 1530277
*				Aaron Hamilton
*
* Course Code: EGP-300
* Section: 01
* Project Name: HW2
* Certificate of Authenticity :
*		We certify that this work is entirely our own.  The assessor of this 
		project may reproduce this project and provide copies to other academic staff, 
		and/or communicate a copy of this project to a plagiarism-checking service, which 
		may retain a copy of the project on its database.
*/

// TODO
// START WITH PHONG
// USE RAMP TO GET FINAL RESULT

#version 410

in vec2 vPassTexcoord;
in vec3 vPassNormal;
in vec3 vPassLight;
in vec3 vPassView;

uniform sampler2D uTex_dm;
uniform sampler2D uTex_sm;
uniform sampler2D uTex_rm;

out vec4 rtFragColor;

//float diffuseCoeff(in vec3 L, in vec3 N)
//{
//	float rampCoord = dot(L, N) * 0.5 + 0.5;
//
//	return texture(uTex_rm, rampCoord);
//}

void main()
{
	vec4 diffuseSample = texture(uTex_dm, vPassTexcoord);
	vec4 specularSample = texture(uTex_sm, vPassTexcoord);

	vec3 L = normalize(vPassLight);
	vec3 N = normalize(vPassNormal);

	float diffuse = dot(L, N);
	float rampCoord = diffuse * 0.5 + 0.5;
	vec2 rampUV = vec2(rampCoord, 0.5);
	float celSample = texture(uTex_rm, rampUV).r; //diffuseCoeff(L, N);

	vec3 V = normalize(vPassView);
	vec3 R = (diffuse + diffuse) * N - L;
	float specular = dot(V, R);

	diffuse = max(0.0, diffuse);
	specular = max(0.0, specular);

	//specular *= specular;
	//specular *= specular;
	//specular *= specular;
	//specular *= specular;

	rampCoord = specular * 0.5 + 0.5;
	rampUV = vec2(rampCoord, 0.5);
	float celSpecSample = texture(uTex_rm, rampUV).r;

	celSpecSample *= celSpecSample;
	celSpecSample *= celSpecSample;
	celSpecSample *= celSpecSample;
	celSpecSample *= celSpecSample;

	diffuse = celSample;
	specular = celSpecSample;

	vec3 Phong = diffuseSample.rgb * diffuse
					+ specularSample.rgb * specular
					+ vec3(0.01, 0.0, 0.02);

	rtFragColor = vec4(Phong, diffuseSample.a);

	// DEBUGGING
	//rtFragColor = diffuseSample;
	//rtFragColor = vec4(diffuse, diffuse, diffuse, 1);
	//rtFragColor = celSample;
}