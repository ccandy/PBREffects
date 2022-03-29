#ifndef MATHFUNCTION_INCLUDED
#define MATHFUNCTION_INCLUDED

float Pow2(float a) 
{
	return a * a;
}

float Pow5(float a) 
{
	return a * a * a * a * a;
}

float Dot(float3 v1, float3 v2)
{
	return saturate(dot(v1, v2));
}

float DotMax(float3 v1, float3 v2, float floatPoint) 
{
	return max(saturate(dot(v1, v2)), floatPoint);
}

#endif