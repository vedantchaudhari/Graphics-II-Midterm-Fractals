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

// http://www.geeks3d.com/20140201/glsl-menger-sponge-raymarching-code-samples-updated/

#version 410

#define PI 3.14159265

in vec2 vPassTexcoord;
in vec3 vPassNormal;
in vec3 vPassLight;
in vec3 vPassView;

out vec4 rtFractal;

uniform int uIter;
uniform float uTime;
uniform vec4 uEyePos_obj;
uniform vec4 uLightPos_obj;
uniform mat4 uMVP;
uniform vec4 uColor;
uniform float uZoom;

vec2 objUnion(in vec2 o0, in vec2 o1)
{
	if (o0.x < o1.x)
		return o0;
	else
		return o1;
}

// floor
vec2 objFloor(in vec3 p)
{
	return vec2(p.y + 10.0, 0);
}


// floor color (checkerboard)
vec3 floorColor(in vec3 p)
{
	if (fract(p.x * 0.2) > 0.2)
	{
		if (fract(p.z * 0.2) > 0.2)
			return vec3(0, 0.1, 0.2);
		else
			return vec3(1.0, 1.0, 1.0);
	}
	else
	{
		if (fract(p.z * 0.2) > 0.2)
			return vec3(1.0, 1.0, 1.0);
		else
			return vec3(0.3, 0.0, 0.0);
	}
}

// primitive color
vec3 primitiveColor(in vec3 p)
{
	return vec3(0.6, 0.6, 0.8);
}

// menger routines

float maxComp(vec3 p)
{
	float m1 = max(p.x, p.y);
	return max(m1, p.z);
}

vec2 objBoxS(vec3 p, vec3 b)
{
	vec3 di = abs(p) - b;
	float mc = maxComp(di);
	float d = min(mc, length(max(di, 0.0)));
	return vec2(d, 1);
}

vec2 objBox(vec3 p)
{
	vec3 b = vec3(4.0, 4.0, 4.0);
	return objBoxS(p, b);
}

vec2 objCross(in vec3 p)
{
	float inf = 100.0;
	vec2 da = objBoxS(p.xyz, vec3(inf, 2.0, 2.0));
	vec2 db = objBoxS(p.yzx, vec3(2.0, inf, 2.0));
	vec2 dc = objBoxS (p.zxy, vec3(2.0, 2.0, inf));
	return vec2(min(da.x, min(db.x, dc.x)), 1.0);
}

vec2 objMengerSimple(in vec3 p)
{
	vec2 d1 = objBox(p);
	vec2 d2 = objCross(p / 3.0);
	float d = max(d1.x, -d2.x);

	return vec2(d, 1.0);
}

vec2 objMenger(in vec3 p)
{
	vec2 d2 = objBox(p);
	float s = 1.0;

	for (int m = 0; m < 3; m++)
	{
		vec3 a = mod(p*s, 2.0) - 1.0;
		s *= 3.0;

		vec3 r = 1.0 - 4.0 * abs(a);
		vec2 c = objCross(r) / s;
		
		d2.x = max(d2.x, c.x);
	}

	return d2;
}

// objects union
vec2 distToObj(in vec3 p)
{
	return objUnion(objFloor(p), objMenger(p));
}

void main()
{
	vec2 q = vPassTexcoord;
	vec2 vPos = -1.0 + 2.0 * q;

	// camera animation
	vec3 vuv = vec3(0.0, 1.0, 0.0);
	vec3 vrp = vec3(0.0, 0.0, 0.0);
	vec3 prp = vPassView;


	// camera setup
	vec3 vpn = normalize(vrp - prp);
	vec3 u = normalize(cross(vuv, vpn));
	vec3 v = cross(vpn, u);
	vec3 vcv = (prp + vpn);
	float aspect = //(vPassView.x / vPassView.y);// / vPassView.z);
					(vPassTexcoord.x / vPassTexcoord.y);
	vec3 scrCoord = vcv + vPos.x * u * aspect + vPos.y * v;
	vec3 scp = normalize(scrCoord - prp * uIter);

	// raymarching
	const vec3 E = vec3(0.02, 0.0, 0.0);
	const float maxD = 100.0; // max depth
	vec2 d = vec2(0.02, 0.0);
	vec3 d2 = vec3(0.02, 0.0, 0.0);
	vec3 c, p, n;

	float f = 1.0;
	for (int i = 0; i < 256; ++i)
	{
		if ((abs(d.x) < 0.001) || (f > maxD / 2))
			break;

		f += d.x;
		p = prp + scp* f;
		d = distToObj(p);
	}

	if (f < maxD)
	{
		if (d.y == 0.0)
			c = floorColor(p);
		else
			c = primitiveColor(p);

		n = normalize(
			vec3(d.x - distToObj(p - E.xyy).x,
				 d.x - distToObj(p - E.yxy).x,
				 d.x - distToObj(p - E.yyx).x));
									// change prp
		float b = dot(n, normalize(prp - p));
		rtFractal = vec4((b * c + pow(b, 60.0)) * (1.0 - f * 0.01), 1.0);
	}
	else
	{
		rtFractal = vec4(0.0, 1.0, 1.0, 1.0);
	}

	//rtFractal = vec4(0.0, 0.0, 0.0, 1.0);
}