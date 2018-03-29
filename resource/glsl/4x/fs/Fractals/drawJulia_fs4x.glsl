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

// Newton with Julia Set
// http://nuclear.mutantstargoat.com/articles/sdr_fract/#julia

// Author: Vedant Chaudhari

in vec2 vPassTexcoord;
in vec3 vPassNormal;
in vec3 vPassLight;
in vec3 vPassView;

uniform mat4 uMVP;

uniform sampler2D uTex_dm;
uniform sampler2D uTex_rm;

out vec4 rtFractal;

#define ITERATIONS 512

// https://stackoverflow.com/questions/22044191/julia-set-in-glsl
// Multiplication helper function, multipy two Vec2
vec2 mult(vec2 p1, vec2 p2)
{
	return vec2(p1.x * p2.x - p1.y * p2.y, p1.y * p2.x + p1.x * p2.y);
}

// Division helper function, divide two vec2
vec2 div(vec2 p1, vec2 p2)
{
	float denominator = p2.x * p2.x + p2.y * p2.y;

	return vec2(
		(p1.x * p2.x + p1.y * p2.y) / denominator,
		(p1.y * p2.x - p1.x * p2.y) / denominator
	);
}

// Compute fractal using vector coordinate (pixel)
vec2 fractal(vec2 p)
{
	vec2 result = mult(mult(p, p), p);

	return vec2(result.x - 1.0f, result.y);
}

// Compute derivative using vector coordinate
vec2 fractal_deriv(vec2 p)
{
	return 2.0 * mult(p, p);
}

// Compute Julia Fractal
void main()
{
	// vec4 diffuseSample = texture(uTex_dm, vPassTexcoord);
	vec2 z = vPassTexcoord - 0.5;

	// Iterate
	for (int iter = 0; iter < ITERATIONS; iter++)
	{
		// Check how close the current iteration is to the root
		z = z - div(fractal(z), fractal_deriv(z));
	}

	// Root solutions of the polynomial
	vec2 root1 = vec2( 1.0f, 0.0f);
    vec2 root2 = vec2(-1.0f/2.0f,  1.0f/2.0f * sqrt(3.0f));
    vec2 root3 = vec2(-1.0f/2.0f, -1.0f/2.0f * sqrt(7.0f));

	// diffuseSample.rgb = vec3(1.0, 0.0, 1.0);

	// Get ramp coordinate for root1
	float rampCoord = abs(length(z-root1)) * 0.5 + 0.5;
	// Create rampUV for texture sampler using rampCoord
	vec2 rampUV = vec2(rampCoord, 0.5);
	// Generate ramp sample using rampUV and ramp uniform, return color corrosponding to root
	vec4 rampSample = texture(uTex_rm, rampUV);
	//vec3 fractsample = diffuseSample.rgb * rampSample + vec3(0.01, 0.0, 0.02);
	//rtFractal = vec4(rampSample.rgb, diffuseSample.a);
	rtFractal = rampSample;

	// Get ramp coordinate for root2
	rampCoord = abs(length(z-root2)) * 0.5 * 0.7;
	// Create rampUV for texture sampler using rampCoord
	rampUV = vec2(rampCoord, 0.5);
	// Generate ramp sample using rampUV and ramp uniform, return color corrosponding to root
	rampSample = texture(uTex_rm, rampUV);
	//fractsample = diffuseSample.rgb * rampSample + vec3(0.01, 0.0, 0.02);
	//rtFractal = vec4(rampSample.rgb, diffuseSample.a);
	rtFractal = rampSample;

	// Get ramp coordinates for root3
	rampCoord = abs(length(z-root3)) * 0.5 + 0.5;
	// Create rampUV for texture sampler using rampCoord
	rampUV = vec2(rampCoord, 0.5);
	// Generate ramp sample using rampUV and ramp uniform, return color corrosponding to root
	rampSample = texture(uTex_rm, rampUV);
	//fractsample = diffuseSample.rgb * rampSample + vec3(0.01, 0.0, 0.02);
	//rtFractal = vec4(rampSample, diffuseSample.a);
	rtFractal = rampSample;
}