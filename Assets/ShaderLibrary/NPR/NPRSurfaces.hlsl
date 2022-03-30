#ifndef NPRSURFACE_INCLUDED
#define NPRSURFACE_INCLUDED

struct CelSurface 
{
	float4 BaseColor;
	float4 TexCol;
	float3 Normal;
	float3 ShadowColor;
	float ShadowSmooth;
	float Threshold;
};

CelSurface CreateCelSurface(float4 baseColor, float4 texCol, float3 normal, float3 scolor, float shadowsmooth, float threshold) 
{
	CelSurface surface;

	surface.BaseColor = baseColor;
	surface.TexCol = texCol;
	surface.Normal = normal;
	surface.ShadowColor = scolor;
	surface.ShadowSmooth = shadowsmooth;
	surface.Threshold = threshold;

	return surface;
}



#endif