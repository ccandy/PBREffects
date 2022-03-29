#ifndef DEFAULSURFACE_INCLUDED
#define DEFAULSURFACE_INCLUDED

struct DefaultSurface
{
	float4 BaseColor;
	float3 Normal;
	float Shinness;
	float SpecStrength;
};

DefaultSurface CreateRegularSurface(float4 color, float4 texColor, float3 normal, float shinness, float specstrength)
{
	DefaultSurface surface;

	surface.BaseColor = color * texColor;
	surface.Normal = normal;
	surface.Shinness = shinness;
	surface.SpecStrength = specstrength;

	return surface;
}

#endif