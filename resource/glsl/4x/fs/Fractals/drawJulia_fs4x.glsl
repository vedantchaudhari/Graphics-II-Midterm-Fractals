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

#version 410

// Newton

in vec2 vPassTexcoord;
in vec3 vPassNormal;
in vec3 vPassLight;
in vec3 vPassView;

uniform mat4 uMVP;

uniform sampler2D uTex_dm;
uniform sampler2D uTex_rm;

out vec4 rtFractal;

#define ITERATIONS 1024

// https://stackoverflow.com/questions/22044191/julia-set-in-glsl
vec2 mult(vec2 p1, vec2 p2)
{
	return vec2(p1.x * p2.x - p1.y * p2.y, p1.y * p2.x + p1.x * p2.y);
}

// https://stackoverflow.com/questions/22044191/julia-set-in-glsl
vec2 div(vec2 p1, vec2 p2)
{
	float denominator = p2.x * p2.x + p2.y * p2.y;

	return vec2(
		(p1.x * p2.x + p1.y * p2.y) / denominator,
		(p1.y * p2.x - p1.x * p2.y) / denominator
	);
}

// https://stackoverflow.com/questions/22044191/julia-set-in-glsl
vec2 fractal(vec2 p)
{
	vec2 result = mult(mult(p, p), p);

	return vec2(result.x - 1.0f, result.y);
}

// https://stackoverflow.com/questions/22044191/julia-set-in-glsl
vec2 fractal_deriv(vec2 p)
{
	return 2 * mult(p, p);
}

// Compute Julia Fractal
void main()
{
	vec2 z = vPassTexcoord;

	for (int iter = 0; iter < ITERATIONS; ++iter)
	{
		z = z - div(fractal(z), fractal_deriv(z));
	}

	vec2 root1 = vec2( 1.0f, 0.0f);
    vec2 root2 = vec2(-1.0f/2.0f,  1.0f/2.0f * sqrt(3.0f));
    vec2 root3 = vec2(-1.0f/2.0f, -1.0f/2.0f * sqrt(3.0f));

    if (abs(length(z - root1)) < 0.5f)
	{
        rtFractal = vec4 (1, 0.5, 0, 1);
    }
    else if(abs(length(z - root2)) < 0.01f)
	{
        rtFractal = vec4 (0, 1, 1, 1);
    }
    else if(abs(length(z - root3)) < 0.01f)
	{
        rtFractal = vec4 (1, 0, 0.5, 1);
    }
    else
	{
        rtFractal = vec4 (0, 0, 0, 1);
	}
}