#ifndef DEFAULSURFACE_INCLUDED
#define DEFAULSURFACE_INCLUDED

struct DefaultSurface
{
	float4 BaseColor;
	float3 Normal;
	float NormalScale;
	float Shinness;
	float SpecStrength;
};

DefaultSurface CreateRegularSurface(float4 color, float4 texColor, float3 normal, float shinness, float specstrength, float normalscale)
{
	DefaultSurface surface;

	surface.BaseColor = color * texColor;
	surface.Normal = normal;
	surface.Shinness = shinness;
	surface.SpecStrength = specstrength;
	surface.NormalScale = normalscale;
	return surface;
}

#endif