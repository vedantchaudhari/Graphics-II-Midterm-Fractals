/*
* Team Members:
*				Vedant Chaudhari 1530277
*				Aaron Hamilton
*
* Course Code: EGP-300
* Section: 01
* Project Name: Fractal Midterm
* Certificate of Authenticity :
*		We certify that this work is entirely our own.  The assessor of this 
		project may reproduce this project and provide copies to other academic staff, 
		and/or communicate a copy of this project to a plagiarism-checking service, which 
		may retain a copy of the project on its database.
*/

// Author: Vedant Chaudhari

// http://nuclear.mutantstargoat.com/articles/sdr_fract/#julia

#version 410

in vec2 vPassTexcoord;
in vec3 vPassNormal;
in vec3 vPassLight;
in vec3 vPassView;

uniform mat4 uMVP;

uniform sampler2D uTex_dm;
uniform sampler2D uTex_rm;

uniform int uIter;	// Number of iterations

out vec4 rtFractal;

// Stack Overflow

void main()
{
	// Scale point by input transformation matrix
	//vec2 point = (uMVP * vec4(vPassTexcoord, 0, 1)).xy;
	//vec2 point = vec4(vPassNormal, 1).xy;
	vec2 point = vPassTexcoord - 0.5;
	vec2 c = point;
	
	// Set default color
	vec3 color = vec3(1.0, 1.0, 0.0);

	// Iterate up to max
	for (int iter = 0; iter < uIter; iter++)
	{
		point = vec2(3.0 * point.x * point.x - point.y * point.y, 6.0 * point.x * point.y) + c;

		// Check if point c is part of the set 
		if (dot(point, point) > 16.0) // Try 16, force iterations that don't mean anything
		{
			float r = float(iter - 1) - log(((log(dot(point, point)))/log(2.0)))/log(2.0);
			
			// HSV coloring algorithm
			color = vec3(0.95 + 0.12 * r, 1.0, 0.2 + 0.4 * (1.0 + sin(0.3 * r)));

			break;
		}
	}

	// Convert from HSV to RGB
	// https://gist.github.com/patriciogonzalezvivo/114c1653de9e3da6e1e3
	vec4 k = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
	vec3 m = abs(fract(color.xxx + k.xyz) * 6.0 - k.www);

	rtFractal.rgb = color.z * mix(k.xxx, clamp(m - k.xxx, 0.0, 4.0), color.y);
	rtFractal.a = 1.0;
}